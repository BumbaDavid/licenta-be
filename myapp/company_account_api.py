from tastypie.authentication import ApiKeyAuthentication
from tastypie.authorization import DjangoAuthorization
from tastypie.exceptions import ImmediateHttpResponse, BadRequest
from tastypie.http import HttpUnauthorized, HttpBadRequest, HttpForbidden, HttpNotFound, HttpNoContent
from tastypie.resources import ModelResource
from tastypie import fields
from django.shortcuts import get_object_or_404
from django.urls import re_path

from myapp.custom_auth import CustomApiKeyAuthentication, CustomDjangoAuthorization
from myapp.models import CompanyDetails, JobOffers, JobApplication
from django.db import IntegrityError
import logging

logger = logging.getLogger(__name__)


class CompanyDetailsResource(ModelResource):
    user = fields.ToOneField('myapp.user_login_api.UserLoginResource', 'user', full=True)

    class Meta:
        queryset = CompanyDetails.objects.all()
        resource_name = 'companyDetails'
        authentication = ApiKeyAuthentication()
        always_return_data = True
        allowed_methods = ['get', 'post', 'put', 'patch', 'delete']
        excludes = ['user']


class JobOffersResource(ModelResource):
    company = fields.ForeignKey(CompanyDetailsResource, 'company', full=True, null=True, blank=True)
    requirements = fields.ListField(attribute='requirements', null=True, blank=True)

    class Meta:
        queryset = JobOffers.objects.all()
        resource_name = 'jobOffers'
        authentication = CustomApiKeyAuthentication()
        authorization = CustomDjangoAuthorization()
        always_return_data = True
        allowed_methods = ['get', 'post', 'put', 'patch', 'delete']
        excludes = ['user']
        filtering = {
            'company': ('exact', 'in'),
            'job_category': ('exact', 'startswith'),
        }

    def prepend_urls(self):
        return [
            re_path(r"^(?P<resource_name>%s)/(?P<pk>\d+)/apply/$" % self._meta.resource_name,
                    self.wrap_view('apply_for_job'), name="api_apply_for_job"),
            re_path(r"^(?P<resource_name>%s)/applied/$" % self._meta.resource_name,
                    self.wrap_view('get_applied_jobs'), name="api_get_applied_jobs"),
            re_path(r"^(?P<resource_name>%s)/(?P<pk>\d+)/cancel-application/$" % self._meta.resource_name,
                    self.wrap_view('cancel_application'), name="api_cancel_application"),

        ]

    def dehydrate(self, bundle):
        company_bundle = bundle.data.get('company', None)
        if company_bundle:
            if 'user' in company_bundle.data:
                del company_bundle.data['user']

        bundle = super(JobOffersResource, self).dehydrate(bundle)
        if bundle.data.get('requirements'):
            bundle.data['requirements'] = bundle.obj.requirements

        return bundle

    def obj_create(self, bundle, **kwargs):
        if not bundle.request.user.has_perm('myapp.add_joboffers'):
            raise ImmediateHttpResponse(HttpUnauthorized())  # Raise an exception with the HTTP response
        try:
            bundle.data['company'] = CompanyDetails.objects.get(user=bundle.request.user)
        except CompanyDetails.DoesNotExist:
            raise IntegrityError('no associated company found for the given user.')

        return super(JobOffersResource, self).obj_create(bundle, **kwargs)

    def apply_filters(self, request, applicable_filters):
        show_all = request.GET.get('all', 'false').lower() == 'true'
        if not show_all:
            if 'company' not in applicable_filters:
                user = request.user
                if user and hasattr(user, 'company_profile'):
                    applicable_filters['company__id'] = user.company_profile.id

        return super(JobOffersResource, self).apply_filters(request, applicable_filters)

    def obj_update(self, bundle, skip_errors=False, **kwargs):
        if bundle.request.method.lower() == 'patch':
            try:
                job_offer_id = kwargs.get('pk')
                job_offer = JobOffers.objects.get(id=job_offer_id)
            except JobOffers.DoesNotExist:
                raise BadRequest("Job offer does not exist")

            changed_values = bundle.data.get('changedValues', {})

            for field, value in changed_values.items():
                if field == 'requirements':
                    # Directly handle requirements if it's a list of strings
                    if isinstance(value, list) and all(isinstance(item, str) for item in value):
                        job_offer.requirements = value
                    else:
                        raise BadRequest("Invalid format for requirements")
                elif hasattr(job_offer, field):
                    # Set other attributes normally if they exist on the model
                    setattr(job_offer, field, value)
                else:
                    raise BadRequest(f"Invalid field: {field}")

            job_offer.save()

            logging.debug(f"Requirements after save: {job_offer.requirements}")
            print(f"Requirements after save: {job_offer.requirements}")

            bundle.obj = job_offer
            return bundle

        return super().obj_update(bundle, **kwargs)

    def apply_for_job(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        self.is_authenticated(request)
        self.throttle_check(request)

        user = request.user
        if not user.is_authenticated:
            return self.create_response(request, {'error': 'Authentication required'}, HttpUnauthorized)

        logger.debug(f"User account type: {user.account_type}")
        if user.account_type != 'normal':
            return self.create_response(request, {'error': 'Only normal users can apply for job offers'}, HttpForbidden)

        job_offer = get_object_or_404(JobOffers, pk=kwargs['pk'])

        if JobApplication.objects.filter(user=user, job_offer=job_offer).exists():
            return self.create_response(request, {'error': 'You have already applied for this job'}, HttpBadRequest)

        JobApplication.objects.create(user=user, job_offer=job_offer)
        return self.create_response(request, {'message': 'Application submitted successfully'})

    def get_applied_jobs(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        self.is_authenticated(request)
        self.throttle_check(request)

        user = request.user
        if not user.is_authenticated:
            return self.create_response(request, {'error': 'authentication is required'}, HttpUnauthorized)

        if user.account_type != 'normal':
            return self.create_response(request, {'error': 'only normal users can have applications to jobs'}, HttpForbidden)

        applied_jobs = JobOffers.objects.filter(jobapplication__user=user)
        if not applied_jobs.exists():
            return self.create_response(request, {'objects': []})

        bundles = [self.build_bundle(obj=job, request=request) for job in applied_jobs]
        bundles = [self.full_dehydrate(bundle) for bundle in bundles]
        return self.create_response(request, {'objects': bundles})

    def cancel_application(self, request, **kwargs):
        self.method_check(request, allowed=['delete'])
        self.is_authenticated(request)
        self.throttle_check(request)

        user = request.user

        if not user.is_authenticated:
            logger.error("User is not authenticated")
            return self.create_response(request, {'error': 'Authentication required'}, HttpUnauthorized)

        logger.debug(f"User account type: {user.account_type}")
        if user.account_type != 'normal':
            logger.error(f"User account type is {user.account_type}, but only 'normal' users can cancel applications")
            return self.create_response(request, {'error': 'Only normal users can cancel job applications'}, HttpForbidden)

        job_offer = get_object_or_404(JobOffers, pk=kwargs['pk'])
        logger.debug(f"Job offer: {job_offer}")

        job_application = JobApplication.objects.filter(user=user, job_offer=job_offer).first()

        if not job_application:
            return self.create_response(request, {'error  ': 'no job application found'}, HttpNotFound)

        job_application.delete()

        return self.create_response(request, {'success': 'job application canceled successfully'}, HttpNoContent)
