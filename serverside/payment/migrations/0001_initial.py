# Generated by Django 5.0.2 on 2024-03-21 19:50

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('booking', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='Payment',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('amount', models.FloatField(blank=True, default=0.0, null=True)),
                ('transaction_id', models.CharField(max_length=255)),
                ('token', models.CharField(max_length=255)),
                ('service_type', models.CharField(max_length=255)),
                ('payment_type', models.CharField(max_length=255)),
                ('payment_date', models.DateTimeField()),
                ('booking', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='booking.book')),
            ],
        ),
    ]