from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from .models import UserLogin


class UserLoginAdmin(UserAdmin):
    model = UserLogin
    list_display = ['email', 'username', 'is_active', 'is_staff']


admin.site.register(UserLogin, UserLoginAdmin)
