# Generated by Django 5.0.6 on 2024-06-18 14:58

import pgvector.django
from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0025_alter_joboffers_description_vector_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='usercv',
            name='abilities_vector',
            field=pgvector.django.VectorField(blank=True, dimensions=1536, null=True),
        ),
        migrations.AddField(
            model_name='usercv',
            name='experience_vector',
            field=pgvector.django.VectorField(blank=True, dimensions=1536, null=True),
        ),
        migrations.AddField(
            model_name='usercv',
            name='hobbies_vector',
            field=pgvector.django.VectorField(blank=True, dimensions=1536, null=True),
        ),
        migrations.AddField(
            model_name='usercv',
            name='languages_vector',
            field=pgvector.django.VectorField(blank=True, dimensions=1536, null=True),
        ),
        migrations.AddField(
            model_name='usercv',
            name='studies_vector',
            field=pgvector.django.VectorField(blank=True, dimensions=1536, null=True),
        ),
    ]