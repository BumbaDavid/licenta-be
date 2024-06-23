import json
import logging
from django.contrib.auth import get_user_model, authenticate
from django.urls import re_path
from tastypie.exceptions import NotFound, BadRequest
from tastypie.http import HttpUnauthorized, HttpForbidden, HttpNoContent, HttpBadRequest, HttpAccepted
from tastypie.models import ApiKey
from tastypie.resources import ModelResource
from django.contrib.auth.models import Group
from tastypie.authorization import Authorization
from myapp.models import UserProfile, CompanyDetails, UserCV

UserLogin = get_user_model()

logger = logging.getLogger('myapp')


class UserLoginResource(ModelResource):
    class Meta:
        queryset = UserLogin.objects.all()
        resource_name = 'userLogin'
        allowed_methods = ['get', 'post', 'put', 'delete']
        always_return_data = True
        authorization = Authorization()

    def obj_create(self, bundle, **kwargs):
        bundle = super(UserLoginResource, self).obj_create(bundle, **kwargs)
        account_type = bundle.data.get('account_type')
        bundle.obj.set_password(bundle.data.get('password'))

        bundle.obj.save()
        if account_type == "normal":
            user_profile = UserProfile(
                user=bundle.obj,
                address="",
                phone_number="",
                age="",
            )
            user_profile.save()

            user_cv = UserCV(user=bundle.obj)
            user_cv.save()

            user_profile_group = Group.objects.get(name='UserProfile')
            bundle.obj.groups.add(user_profile_group)
            user_cv_group = Group.objects.get(name='UserCV')
            bundle.obj.groups.add(user_cv_group)
            job_application_group = Group.objects.get(name='JobApplication')
            bundle.obj.groups.add(job_application_group)

        elif account_type == "company":
            company_details_group = Group.objects.get(name="CompanyDetails")
            bundle.obj.groups.add(company_details_group)
            job_offers_group = Group.objects.get(name="JobOffers")
            bundle.obj.groups.add(job_offers_group)
            bundle.obj.save()

            company_profile = CompanyDetails(
                user=bundle.obj,
                company_name="",
                address="",
                contact_email="",
                phone="",
                description=""
            )
            company_profile.save()

        bundle.obj.save()
        return bundle

    def obj_delete(self, bundle, **kwargs):
        try:
            obj = UserLogin.objects.get(pk=kwargs['pk'])
        except UserLogin.DoesNotExist:
            raise NotFound("user login with specified Id does not exist")
        obj.delete()

    def prepend_urls(self):
        return [
            re_path(r"^(?P<resource_name>%s)/login/$" % self._meta.resource_name, self.wrap_view('login'),
                    name="api_login"),
            re_path(r"^(?P<resource_name>%s)/logout/$" % self._meta.resource_name, self.wrap_view('logout'),
                    name="api_logout"),
            re_path(r"^(?P<resource_name>%s)/validate/$" % self._meta.resource_name, self.wrap_view('validate'),
                    name="api_validate"),
            re_path(r"^(?P<resource_name>%s)/user-data/$" % self._meta.resource_name, self.wrap_view('get_user_data'),
                    name="api_user_data"),
            re_path(r"^(?P<resource_name>%s)/update-user/$" % self._meta.resource_name, self.wrap_view('update_user'),
                    name="api_update_user"),
        ]

    def login(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        data = self.deserialize(request, request.body, format=request.META.get('CONTENT_TYPE', 'application/json'))
        username = data.get('username', '')
        password = data.get('password', '')

        user = authenticate(username=username, password=password)

        if user:
            if user.is_active:
                api_key, created = ApiKey.objects.get_or_create(user=user)
                response_data = {
                    'api_key': api_key.key,
                    'username': user.username,
                    'account_type': user.account_type
                }
                return self.create_response(request, {'data': response_data}, HttpAccepted)
            else:
                return self.create_response(request, {'error': 'Account is disabled'}, HttpForbidden)
        else:
            return self.create_response(request, {'error': 'Invalid login'}, HttpUnauthorized)

    def logout(self, request, **kwargs):
        self.method_check(request, allowed=['post'])

        api_key = request.META.get('HTTP_AUTHORIZATION')
        if not api_key:
            return self.create_response(request, {'error': 'No API key provided'}, HttpUnauthorized)

        try:
            key = ApiKey.objects.get(key=api_key)
            key.delete()
            return self.create_response(request, {}, HttpNoContent)
        except (IndexError, ApiKey.DoesNotExist):
            return self.create_response(request, {'error': 'Invalid API key'}, HttpUnauthorized)

    def validate(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        api_key = request.META.get('HTTP_AUTHORIZATION')
        if not api_key:
            return self.create_response(request, {'valid': False}, HttpUnauthorized)
        try:
            ApiKey.objects.get(key=api_key)
            return self.create_response(request, {'valid': True})
        except (IndexError, ApiKey.DoesNotExist):
            return self.create_response(request, {'valid': False}, HttpUnauthorized)

    def get_user_data(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        api_key = request.META.get('HTTP_AUTHORIZATION')
        if not api_key:
            return self.create_response(request, {'error': 'No API Key provided'}, HttpUnauthorized)
        try:
            api_key_obj = ApiKey.objects.get(key=api_key)
            user = api_key_obj.user
            user_data = UserLogin.objects.get(id=user.id)
            data_to_send = {}
            if user_data.account_type == 'normal':
                profile = getattr(user_data, 'user_profile', None)
                user_cv = getattr(user_data, 'user_cv', None)
                data_to_send = {
                    'user_id': user_data.id,
                    'username': user_data.username,
                    'email': user_data.email,
                    'first_name': user_data.first_name,
                    'last_name': user_data.last_name,
                    'account_type': user_data.account_type,
                    'user': {
                        'address': profile.address,
                        'phone_number': profile.phone_number,
                        'age': profile.age
                    },
                    'user_cv': {
                        'studies': user_cv.studies if user_cv else [],
                        'experience': user_cv.experience if user_cv else [],
                        'abilities': user_cv.abilities if user_cv else [],
                        'languages': user_cv.languages if user_cv else [],
                        'hobbies': user_cv.hobbies if user_cv else []
                    },
                    'date_joined': user_data.date_joined
                }
            elif user_data.account_type == 'company':
                company_profile = getattr(user_data, 'company_profile', None)
                data_to_send = {
                    'id': user.id,
                    'username': user_data.username,
                    'email': user_data.email,
                    'account_type': user_data.account_type,
                    'company_profile': {
                        'company_name': company_profile.company_name,
                        'address': company_profile.address,
                        'email': company_profile.contact_email,
                        'phone': company_profile.phone,
                        'description': company_profile.description
                    },
                    'date_joined': user_data.date_joined
                }
            return self.create_response(request, data_to_send)
        except (IndexError, ApiKey.DoesNotExist):
            return self.create_response(request, {'error': 'Invalid API Key'}, HttpUnauthorized)

    def update_user(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        api_key = request.META.get('HTTP_AUTHORIZATION')
        if not api_key:
            return self.create_response(request, {'error': 'No API Key provided'}, HttpUnauthorized)
        try:
            obj_user = ApiKey.objects.get(key=api_key)
            user = obj_user.user
            user_login = UserLogin.objects.get(id=user.id)
        except (IndexError, ApiKey.DoesNotExist):
            return self.create_response(request, {'error': 'Invalid API Key'}, HttpUnauthorized)

        try:
            data = json.loads(request.body)
        except ValueError:
            return self.create_response(request, {'error': 'invalid json data'}, HttpBadRequest)

        user_login_attributes = ['username', 'email', 'first_name', 'last_name', 'account_type']
        user_profile_attributes = ['address', 'phone_number', 'age']
        print("data items", data.items())
        for key, value in data.items():
            if user_login.account_type == 'normal':
                if key in user_login_attributes:
                    setattr(user, key, value)
                elif key in user_profile_attributes:
                    print("KEY : ", key)
                    if hasattr(user, 'user_profile'):
                        print("value : ", value)
                        setattr(user.user_profile, key, value)
            elif user_login.account_type == 'company':
                field_names = CompanyDetails.get_field_name()
                if key in user_login_attributes:
                    setattr(user, key, value)
                elif key in field_names:
                    print("key : ", key)
                    if hasattr(user, 'company_profile'):
                        print("value : ", value)
                        setattr(user.company_profile, key, value)
        try:
            user.save()
            if user_login.account_type == 'normal' and hasattr(user, 'user_profile'):
                print("user profile : ", user.user_profile)
                user.user_profile.save()
            elif user_login.account_type == 'company' and hasattr(user, 'company_profile'):
                print("company_profile ", user.company_profile)
                user.company_profile.save()
        except Exception as e:
            return self.create_response(request, {'error': str(e)}, BadRequest)

        return self.create_response(request, {'success': 'User updated successfully'}, HttpAccepted)
