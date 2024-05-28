from tastypie.authentication import ApiKeyAuthentication
from tastypie.authorization import DjangoAuthorization
from tastypie.exceptions import ImmediateHttpResponse
from tastypie.http import HttpUnauthorized
from tastypie.resources import ModelResource
from tastypie import fields
from myapp.models import CompanyDetails, JobOffers
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

    class Meta:
        queryset = JobOffers.objects.all()
        resource_name = 'jobOffers'
        authentication = ApiKeyAuthentication()
        authorization = DjangoAuthorization()
        always_return_data = True
        allowed_methods = ['get', 'post', 'put', 'patch', 'delete']
        excludes = ['user']
        filtering = {
            'company': ('exact', 'in'),
            'job_category': ('exact', 'startswith'),
        }

    def dehydrate(self, bundle):
        company_bundle = bundle.data.get('company', None)
        if company_bundle:
            if 'user' in company_bundle.data:
                del company_bundle.data['user']
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
        if 'company' not in applicable_filters:
            user = request.user
            if user and hasattr(user, 'company_profile'):
                applicable_filters['company__id'] = user.company_profile.id
        return super(JobOffersResource, self).apply_filters(request, applicable_filters)
