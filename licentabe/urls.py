
from django.contrib import admin
from django.urls import path, include, re_path
from tastypie.api import Api

from myapp.chatbot_api import ChatbotResource
from myapp.company_account_api import CompanyDetailsResource, JobOffersResource
from myapp.job_applications import JobApplicationResource
from myapp.user_login_api import UserLoginResource
from myapp.user_cv import UserCVResource

v1_api = Api(api_name='v1')
v1_api.register(UserLoginResource())
v1_api.register(UserCVResource())
v1_api.register(CompanyDetailsResource())
v1_api.register(JobOffersResource())
v1_api.register(JobApplicationResource())
v1_api.register(ChatbotResource())
urlpatterns = [
    path('admin/', admin.site.urls),
    re_path(r'^api/', include(v1_api.urls)),
]
