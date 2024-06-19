from tastypie.http import HttpUnauthorized, HttpForbidden, HttpBadRequest
from tastypie.resources import ModelResource
from tastypie.authorization import DjangoAuthorization
from tastypie.authentication import ApiKeyAuthentication
from tastypie import fields
from myapp.models import JobApplication, CompanyDetails, UserCV, UserProfile, UserLogin
from django.urls import re_path
from django.forms.models import model_to_dict


class JobApplicationResource(ModelResource):
    job_offer = fields.ForeignKey('myapp.company_account_api.JobOffersResource', 'job_offer')

    class Meta:
        queryset = JobApplication.objects.all()
        resource_name = 'jobApplication'
        authorization = DjangoAuthorization()
        authentication = ApiKeyAuthentication()
        allowed_methods = ['get', 'post', 'put', 'patch', 'delete']

    def prepend_urls(self):
        return [
            re_path(r"^(?P<resource_name>%s)/get-apps-company/$" % self._meta.resource_name,
                    self.wrap_view('get_job_applications_for_company'), name="api_get_job_applications_for_company")
        ]

    def get_job_applications_for_company(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        self.is_authenticated(request)
        self.throttle_check(request)

        user = request.user

        if not user.is_authenticated:
            return self.create_response(request, {'error': 'authentication is required'}, HttpUnauthorized)

        if user.account_type != 'company':
            return self.create_response(request, {'error': 'only company users can get applications to jobs'}, HttpForbidden)

        try:
            company_details = CompanyDetails.objects.get(user=user)
        except CompanyDetails.DoesNotExist:
            return self.create_response(request, {'error': 'Company details not found'}, HttpBadRequest)
        # Get all job offers for the company
        job_offers = company_details.job_offers.all()

        # Get all job applications for the company's job offers
        job_applications = JobApplication.objects.filter(job_offer__in=job_offers).select_related("user", "job_offer")

        job_applications_data = []
        for app in job_applications:
            user_cv = UserCV.objects.get(user=app.user)
            user_profile = UserProfile.objects.get(user=app.user)
            job_app_data = {
                'id': app.id,
                'applicant': {
                    'user': model_to_dict(app.user, exclude=['password', 'last_login', 'is_superuser', 'is_staff', 'is_active', 'groups', 'username', 'user_permissions', 'date_joined', 'account_type', 'id']),
                    'user_cv': model_to_dict(user_cv, exclude=['user']) if user_cv else {},
                    'user_profile': model_to_dict(user_profile, exclude=['user']) if user_profile else {},
                },
                'job_offer': {
                    'id': app.job_offer.id,
                    'job_position': app.job_offer.job_position,
                    'job_title': app.job_offer.job_title,
                    'job_description': app.job_offer.job_description,
                },
                'application_date': app.application_date
            }
            job_applications_data.append(job_app_data)

        return self.create_response(request, {'job_applications': job_applications_data})
