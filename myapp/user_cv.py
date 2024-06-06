import json

from django.db.models.fields import Field
from django.urls import re_path
from tastypie import fields
from tastypie.authentication import ApiKeyAuthentication
from tastypie.authorization import DjangoAuthorization
from tastypie.exceptions import NotFound, BadRequest, ImmediateHttpResponse
from tastypie.http import HttpUnauthorized, HttpBadRequest, HttpAccepted, HttpCreated
from tastypie.models import ApiKey
from tastypie.resources import ModelResource

from myapp.models import UserCV


class UserCVResource(ModelResource):
    user = fields.ToOneField('myapp.user_login_api.UserLoginResource', 'user', full=True)

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

    def get_model_fields(self):
        model_class = self._meta.object_class
        return [field.name for field in model_class._meta.get_fields()
                if isinstance(field, Field) and not field.many_to_many and not field.auto_created]

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

        fields_to_update = self.get_model_fields()
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
