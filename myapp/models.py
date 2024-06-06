from django.db import models
from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import ArrayField
from pgvector.django import VectorField


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
    salary = models.CharField(max_length=100, null=True, blank=True)
    requirements = ArrayField(models.TextField(), blank=True, default=list)
    location = models.CharField(max_length=100)
    job_position = models.TextField(default="default")
    job_category = models.TextField(default="General")
    company = models.ForeignKey(
        'CompanyDetails',
        on_delete=models.CASCADE,
        related_name='job_offers',
        null=True,
        blank=True
    )

    applicants = models.ManyToManyField(UserLogin, through='JobApplication', related_name='applied_jobs')

    description_vector = VectorField(dimensions=300, default=[0.0] * 300)
    requirements_vector = VectorField(dimensions=300, default=[0.0] * 300)
    location_vector = VectorField(dimensions=300, default=[0.0] * 300)
    job_position_vector = VectorField(dimensions=300, default=[0.0] * 300)
    job_category_vector = VectorField(dimensions=300, default=[0.0] * 300)

    class Meta:
        db_table = 'job_offers_table'


class JobApplication(models.Model):
    user = models.ForeignKey(UserLogin, on_delete=models.CASCADE)
    job_offer = models.ForeignKey(JobOffers, on_delete=models.CASCADE)
    application_date = models.DateTimeField(auto_now_add=True)

    class Meta:
        db_table= 'job_application_table'
        unique_together = ('user', 'job_offer')


class CompanyDetails(models.Model):
    user = models.OneToOneField(UserLogin, on_delete=models.CASCADE, related_name='company_profile')
    company_name = models.CharField(max_length=100, null=True, blank=True)
    address = models.CharField(max_length=100, null=True, blank=True)
    contact_email = models.EmailField(null=True, blank=True)
    phone = models.CharField(max_length=100, null=True, blank=True)
    description = models.TextField(null=True, blank=True)

    class Meta:
        db_table = 'company_details_table'

    @classmethod
    def get_field_name(cls):
        return [field.name for field in cls._meta.get_fields()
                if field.concrete and not field.many_to_many and not field.auto_created]

