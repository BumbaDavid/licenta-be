# Generated by Django 5.0.6 on 2024-06-18 13:29

import pgvector.django
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0024_remove_joboffers_job_category_vector_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='joboffers',
            name='description_vector',
            field=pgvector.django.VectorField(dimensions=1536),
        ),
        migrations.AlterField(
            model_name='joboffers',
            name='location_vector',
            field=pgvector.django.VectorField(dimensions=1536),
        ),
        migrations.AlterField(
            model_name='joboffers',
            name='requirements_vector',
            field=pgvector.django.VectorField(dimensions=1536),
        ),
    ]
