# Generated by Django 5.0.6 on 2024-05-17 20:13

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('myapp', '0006_alter_userprofile_address_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='userprofile',
            name='date_of_birth',
        ),
        migrations.AddField(
            model_name='userprofile',
            name='age',
            field=models.CharField(blank=True, max_length=3, null=True),
        ),
    ]
