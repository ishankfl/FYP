# Generated by Django 5.0.2 on 2024-03-21 19:50

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('account', '0001_initial'),
        ('services', '0001_initial'),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Book',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('location', models.CharField(default=None, max_length=255, verbose_name='Location')),
                ('longitude', models.FloatField()),
                ('latitude', models.FloatField()),
                ('address', models.CharField(max_length=255)),
                ('is_complete', models.BooleanField(default=False)),
                ('is_rescheduled', models.BooleanField(default=False)),
                ('status', models.CharField(choices=[('pending', 'Pending'), ('confirmed', 'Confirmed'), ('completed', 'Completed'), ('canceled', 'Canceled')], max_length=20)),
                ('booking_start_date_time', models.DateTimeField()),
                ('booking_end_date_time', models.DateTimeField()),
                ('expected_hour', models.CharField(max_length=20, verbose_name='Expected Hour')),
                ('is_paid', models.BooleanField(default=False)),
                ('image', models.ImageField(upload_to='booking/')),
                ('by', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='account.customer', verbose_name='Customer')),
                ('service', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='services.services', verbose_name='Service')),
                ('to', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='account.serviceprovider', verbose_name='Service Provider')),
            ],
        ),
        migrations.CreateModel(
            name='BookLocation',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL, verbose_name='User')),
            ],
        ),
        migrations.CreateModel(
            name='CancelBook',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('cancel_reason', models.CharField(max_length=1000)),
                ('book_id', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='booking.book', verbose_name='Cancel BOok')),
            ],
        ),
    ]
