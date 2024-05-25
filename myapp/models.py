from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import ArrayField


class UserLogin(AbstractUser):
    ACCOUNT_TYPE_CHOICES = [
        ('normal', 'Normal'),
        ('company', 'Company')
    ]
    account_type = models.CharField(max_length=7, choices=ACCOUNT_TYPE_CHOICES)

    class Meta:
        db_table = 'user_login_table'


class UserProfile(models.Model):
    user = models.OneToOneField(UserLogin, on_delete=models.CASCADE, related_name='user_profile')
    address = models.CharField(max_length=100, null=True, blank=True)
    phone_number = models.CharField(max_length=100, null=True, blank=True)
    age = models.CharField(max_length=100, blank=True, null=True)

    class Meta:
        db_table = 'user_profile_table'


class UserCV(models.Model):
    user = models.OneToOneField(UserLogin, on_delete=models.CASCADE, related_name='user_cv', null=True, blank=True)
    studies = ArrayField(models.TextField(), blank=True, default=list)
    experience = ArrayField(models.TextField(), blank=True, default=list)
    abilities = ArrayField(models.TextField(), blank=True, default=list)
    languages = ArrayField(models.TextField(), blank=True, default=list)
    hobbies = ArrayField(models.TextField(), blank=True, default=list)

    class Meta:
        db_table = 'user_cv_table'


class JobOffers(models.Model):
    job_description = models.TextField()
    salary = models.DecimalField(max_digits=10, decimal_places=2)
    requirements = models.TextField()
    location = models.CharField(max_length=100)
    job_position = models.TextField(default="default")
    job_category = models.TextField(default="General")

    class Meta:
        db_table = 'job_offers_table'


class CompanyDetails(models.Model):
    user = models.OneToOneField(UserLogin, on_delete=models.CASCADE)
    company_name = models.CharField(max_length=100)
    address = models.CharField(max_length=100)
    email = models.EmailField()
    phone = models.CharField(max_length=100)
    description = models.TextField()
    job_offers = models.ManyToManyField(JobOffers, related_name='companies')

    class Meta:
        db_table = 'company_details_table'
