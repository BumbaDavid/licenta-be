from django.contrib.auth.models import AbstractUser
from django.contrib.postgres.fields import ArrayField
from django.db import models
from pgvector.django import VectorField

from scripts.embeddings import generate_embeddings


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

    studies_vector = VectorField(dimensions=1536, null=True, blank=True)
    experience_vector = VectorField(dimensions=1536, null=True, blank=True)
    abilities_vector = VectorField(dimensions=1536, null=True, blank=True)
    languages_vector = VectorField(dimensions=1536, null=True, blank=True)
    hobbies_vector = VectorField(dimensions=1536, null=True, blank=True)

    def save(self, *args, **kwargs):
        studies = ''.join(self.studies)
        self.studies_vector = generate_embeddings(studies)
        experience = ''.join(self.experience)
        self.experience_vector = generate_embeddings(experience)
        abilities = ''.join(self.abilities)
        self.abilities_vector = generate_embeddings(abilities)
        languages = ''.join(self.languages)
        self.languages_vector = generate_embeddings(languages)
        hobbies = ''.join(self.hobbies)
        self.hobbies_vector = generate_embeddings(hobbies)
        super(UserCV, self).save(*args, **kwargs)

    class Meta:
        db_table = 'user_cv_table'


class JobOffers(models.Model):
    job_description = models.TextField()
    salary = models.CharField(max_length=100, null=True, blank=True)
    requirements = ArrayField(models.TextField(), blank=True, default=list)
    location = models.CharField(max_length=100)
    job_title = models.TextField(default="default")
    job_category = models.TextField(default="General")
    job_type = models.CharField(null=True, blank=True)
    study_level = models.CharField(null=True, blank=True)
    experience_level = models.CharField(null=True, blank=True)
    job_position = models.CharField(null=True, blank=True)
    company = models.ForeignKey(
        'CompanyDetails',
        on_delete=models.CASCADE,
        related_name='job_offers',
        null=True,
        blank=True
    )

    applicants = models.ManyToManyField(UserLogin, through='JobApplication', related_name='applied_jobs')

    description_vector = VectorField(dimensions=1536)
    requirements_vector = VectorField(dimensions=1536)
    location_vector = VectorField(dimensions=1536)

    class Meta:
        db_table = 'job_offers_table'

    def save(self, *args, **kwargs):
        self.description_vector = generate_embeddings(self.job_description)
        requirements_text = ' '.join(self.requirements)
        self.requirements_vector = generate_embeddings(requirements_text)
        self.location_vector = generate_embeddings(self.location)
        super(JobOffers, self).save(*args, **kwargs)


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

