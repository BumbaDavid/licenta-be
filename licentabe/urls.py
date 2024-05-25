
from django.contrib import admin
from django.urls import path, include, re_path
from tastypie.api import Api

from myapp.api import UserLoginResource, UserCVResource

v1_api = Api(api_name='v1')
v1_api.register(UserLoginResource())
v1_api.register(UserCVResource())

urlpatterns = [
    path('admin/', admin.site.urls),
    re_path(r'^api/', include(v1_api.urls)),
]
