# Generated by Django 5.0.6 on 2024-05-18 17:56

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0007_remove_userprofile_date_of_birth_userprofile_age'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='usercv',
            name='user_profile',
        ),
        migrations.AddField(
            model_name='usercv',
            name='user_cv',
            field=models.OneToOneField(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='user_cv', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AlterField(
            model_name='usercv',
            name='abilities',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='usercv',
            name='experience',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='usercv',
            name='hobbies',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='usercv',
            name='languages',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='usercv',
            name='studies',
            field=models.TextField(blank=True, null=True),
        ),
        migrations.AlterField(
            model_name='userprofile',
            name='age',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]
