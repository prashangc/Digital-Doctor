# Generated by Django 4.0.3 on 2022-04-11 11:05

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('blog', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='hospital',
            name='user',
        ),
    ]