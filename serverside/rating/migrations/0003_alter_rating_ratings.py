# Generated by Django 5.0.2 on 2024-03-24 23:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('rating', '0002_rating_delete_reviews'),
    ]

    operations = [
        migrations.AlterField(
            model_name='rating',
            name='ratings',
            field=models.DecimalField(decimal_places=10, max_digits=10),
        ),
    ]