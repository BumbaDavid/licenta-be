# Generated by Django 5.0.6 on 2024-06-06 13:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0019_joboffers_description_vector_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='joboffers',
            name='salary',
            field=models.CharField(blank=True, max_length=100, null=True),
        ),
    ]