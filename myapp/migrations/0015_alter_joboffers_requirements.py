# Generated by Django 5.0.6 on 2024-05-28 11:13

import django.contrib.postgres.fields
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0014_rename_email_companydetails_contact_email'),
    ]

    operations = [
        migrations.AlterField(
            model_name='joboffers',
            name='requirements',
            field=django.contrib.postgres.fields.ArrayField(base_field=models.TextField(), blank=True, default=list, size=None),
        ),
    ]