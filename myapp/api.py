import json
import logging
from django.contrib.auth import get_user_model, authenticate
from django.urls import re_path
from tastypie import fields
from tastypie.authentication import ApiKeyAuthentication
from tastypie.authorization import DjangoAuthorization
from tastypie.exceptions import NotFound, BadRequest, ImmediateHttpResponse, Unauthorized
from tastypie.http import HttpUnauthorized, HttpForbidden, HttpNoContent, HttpBadRequest, HttpAccepted, HttpCreated
from tastypie.models import ApiKey
from tastypie.resources import ModelResource

from myapp.models import UserProfile, UserCV

UserLogin = get_user_model()

logger = logging.getLogger('myapp')


class UserLoginResource(ModelResource):
    class Meta:
        queryset = UserLogin.objects.all()
        resource_name = 'userLogin'
        authorization = DjangoAuthorization()
        allowed_methods = ['get', 'post', 'put', 'delete']
        always_return_data = True
        field = ['username', 'email', 'first_name', 'last_name']

    def obj_create(self, bundle, **kwargs):
        bundle.obj = UserLogin()
        bundle.obj.username = bundle.data.get('username')
        bundle.obj.email = bundle.data.get('email')
        bundle.obj.first_name = bundle.data.get('first_name')
        bundle.obj.last_name = bundle.data.get('last_name')
        bundle.obj.account_type = bundle.data.get('account_type')
        bundle.obj.set_password(bundle.data.get('password'))
        bundle.obj.save()
        user_profile = UserProfile(
            user=bundle.obj,
            address="",
            phone_number="",
            age="",
        )
        user_profile.save()

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
                return self.create_response(request, {'api_key': api_key.key})
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
            profile = user_data.user_profile
            user_cv = getattr(user_data, 'user_cv', None)
            data_to_send = {
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
            if key in user_login_attributes:
                setattr(user, key, value)
            elif key in user_profile_attributes:
                print("KEY : ", key)
                if hasattr(user, 'user_profile'):
                    print("value : ", value)
                    setattr(user.user_profile, key, value)
        try:
            user.save()
            if hasattr(user, 'user_profile'):
                print("user profile : ", user.user_profile)
                user.user_profile.save()
        except Exception as e:
            return self.create_response(request, {'error': str(e)}, BadRequest)

        return self.create_response(request, {'success': 'User updated successfully'}, HttpAccepted)


class UserCVResource(ModelResource):
    user = fields.ToOneField('myapp.api.UserLoginResource', 'user', full=True)

    class Meta:
        queryset = UserCV.objects.all()
        resource_name = 'userCV'
        authorization = DjangoAuthorization()
        authentication = ApiKeyAuthentication()
        always_return_data = True
        allowed_methods = ['get', 'post', 'put', 'patch', 'delete']

    def prepend_urls(self):
        return [
            re_path(r"^(?P<resource_name>%s)/update-cv/$" % self._meta.resource_name, self.wrap_view('update_user_cv'),
                    name="api_update_user_cv")
        ]

    def obj_create(self, bundle, **kwargs):
        auth_header = bundle.request.META.get('HTTP_AUTHORIZATION')
        print("headers", bundle.request.META.get('HTTP_AUTHORIZATION'))
        if not auth_header:
            return self.create_response(bundle.request, {'error': 'HttpUnauthorized'}, HttpUnauthorized)

        try:
            auth_parts = auth_header.split(' ')
            if len(auth_parts) == 2 and auth_parts[0] == 'ApiKey':
                username, api_key = auth_parts[1].split(':')
                api_key_obj = ApiKey.objects.get(key=api_key, user__username=username)
                user = api_key_obj.user
            else:
                return self.create_response(bundle.request, {'error': 'Invalid api key format'}, HttpUnauthorized)
        except ApiKey.DoesNotExist:
            raise BadRequest('invalid api key')

        if hasattr(user, 'user_cv'):
            raise BadRequest('User cv already exists')

        user_cv = UserCV(user=user)

        for key, value in bundle.data.items():
            if hasattr(user_cv, key):
                setattr(user_cv, key, value)
        try:
            user_cv.save()
        except Exception as e:
            raise ImmediateHttpResponse(response=self.create_response(bundle.request, {'error saving cv ': str(e)}))

        bundle.obj = user_cv
        raise ImmediateHttpResponse(response=self.create_response(bundle.request, bundle, response_class=HttpCreated))

    def update_user_cv(self, request, **kwargs):
        self.method_check(request, allowed=['patch', 'delete'])
        api_key = request.META.get('HTTP_AUTHORIZATION')
        if not api_key:
            return self.create_response(request, {'error': 'No API Key provided'}, HttpUnauthorized)
        try:
            obj_user = ApiKey.objects.get(key=api_key)
            user = obj_user.user
        except (IndexError, ApiKey.DoesNotExist):
            return self.create_response(request, {'error': 'Invalid API Key'}, HttpUnauthorized)

        try:
            cv = UserCV.objects.get(user=user)
        except UserCV.DoesNotExist:
            raise NotFound("cv not found lol")

        try:
            payload = json.loads(request.body)
            data = payload.get('data', {})
            action = payload.get('action', '')
        except ValueError:
            return self.create_response(request, {'error': 'invalid json data'}, HttpBadRequest)

        fields_to_update = ['studies', 'experience', 'abilities', 'languages', 'hobbies']
        if request.method.lower() == 'delete':
            try:
                for field in fields_to_update:
                    if field in data:
                        current_values = getattr(cv, field, [])
                        values_after_delete = [item for item in current_values if item not in data[field]]
                        setattr(cv, field, values_after_delete)
                cv.save()
            except Exception as e:
                return self.create_response(request, {'error': str(e)}, HttpBadRequest)

        if request.method.lower() == 'patch':
            if action == 'add':
                try:
                    for field, values in data.items():
                        if field in fields_to_update and isinstance(values, list):
                            current_values = getattr(cv, field, [])
                            setattr(cv, field, current_values + values)
                    cv.save()
                    return self.create_response(request, {'success': 'Entries added successfully'}, HttpAccepted)
                except Exception as e:
                    return self.create_response(request, {'error': str(e)}, HttpBadRequest)
            elif action == 'edit':
                try:
                    for field, details in data.items():
                        if field in fields_to_update and isinstance(details, dict):
                            old_value = details.get('oldValue')
                            new_value = details.get('newValue')
                            current_values = getattr(cv, field, [])
                            if old_value in current_values:
                                index = current_values.index(old_value)
                                current_values[index] = new_value
                            setattr(cv, field, current_values)
                    cv.save()
                    return self.create_response(request, {'success': 'Entries updated successfully'}, HttpAccepted)
                except Exception as e:
                    return self.create_response(request, {'error': str(e)}, HttpBadRequest)

        if request.method.lower() == 'patch':
            return self.create_response(request, {'success': 'User CV updated successfully'}, HttpAccepted)
        elif request.method.lower() == 'delete':
            return self.create_response(request, {'success': 'User CV entries deleted successfully'}, HttpAccepted)