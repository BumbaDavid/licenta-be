from tastypie.authentication import ApiKeyAuthentication
from tastypie.authorization import DjangoAuthorization
from tastypie.http import HttpBadRequest
from tastypie.resources import ModelResource
from django.urls import re_path
from myapp.models import UserLogin, UserProfile, UserCV
from scripts.openai_api import search_jobs, process_user_input
from django.db.models.query import QuerySet


class ChatbotResource(ModelResource):
    class Meta:
        queryset = UserLogin.objects.all()
        resource_name = "chatbot"
        authorization = DjangoAuthorization()
        authentication = ApiKeyAuthentication()

    def prepend_urls(self):
        return [
            re_path(r"^(?P<resource_name>%s)/start/$" % self._meta.resource_name,
                    self.wrap_view('start_interaction'), name="api_start_interaction"),
            re_path(r"^(?P<resource_name>%s)/search/$" % self._meta.resource_name,
                    self.wrap_view('get_job_suggestions'), name="api_get_job_suggestions"),
        ]

    def start_interaction(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        self.is_authenticated(request)
        self.throttle_check(request)

        # Simulate asking user if they want to use their CV
        return self.create_response(request, {'message': 'Would you like to search for jobs based on your CV? Respond with yes or no.'})

    def get_job_suggestions(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        self.is_authenticated(request)
        self.throttle_check(request)

        data = self.deserialize(request, request.body, format=request.META.get('CONTENT_TYPE', 'application/json'))
        user_response = data.get('response', '')
        user = request.user

        if user_response.lower() == 'yes':
            job_matches = process_user_input(user, 'cv', None)
        elif user_response.lower() == 'no' and 'text_input' in data:
            text_input = data['text_input']
            job_matches = process_user_input(user, 'text', text_input=text_input)
        else:
            return self.create_response(request, {"response": "Invalid text input or missing"}, HttpBadRequest)

        if isinstance(job_matches, QuerySet):
            # Serialize the QuerySet into a list of dictionaries
            job_matches = [{
                'id': job.id,
                'job_title': job.job_title,
                'location': job.location,
                'job_category': job.job_category,
                'job_type': job.job_type
            } for job in job_matches]

        return self.create_response(request, {'jobs': job_matches})



