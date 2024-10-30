import datetime
from django.db import models

from account.models import Customer, ServiceProvider, User
from services.models import Services

# Create your models here.


class Book(models.Model):
    """
    Represents a booking between a customer and a service provider.
    """
    by = models.ForeignKey(Customer, verbose_name='Customer',
                           blank=False, on_delete=models.CASCADE)
    service = models.ForeignKey(
        Services, verbose_name='Service', on_delete=models.CASCADE, null=True)
    to = models.ForeignKey(
        ServiceProvider, verbose_name='Service Provider', blank=False, on_delete=models.CASCADE)
    location = models.CharField(max_length=255,
                                default=None, blank=False, verbose_name='Location')
    longitude = models.FloatField()
    latitude = models.FloatField()
    address=models.CharField(max_length=255)
    is_complete = models.BooleanField(default=False)
    is_rescheduled = models.BooleanField(default=False)
    BOOKING_STATUS = (('pending', 'Pending'),
                      ('confirmed', 'Confirmed'),
                      ('completed', 'Completed'),
                      ('canceled', 'Canceled'))

    status = models.CharField(max_length=20, choices=BOOKING_STATUS)
    booking_start_date_time= models.DateTimeField()
    booking_end_date_time= models.DateTimeField()
    # booking_date_end_time=models.DateTimeField(auto_now=True)
    expected_hour = models.CharField(
        max_length=20,
        verbose_name='Expected Hour')
    is_paid=models.BooleanField(default=False)
    image=models.ImageField(upload_to='booking/')

    def __str__(self):
        return f"{str(self.by)}"

 


class CancelBook(models.Model):
    book_id = models.ForeignKey(
        Book, verbose_name='Cancel BOok', on_delete=models.CASCADE)
    cancel_reason = models.CharField(max_length=1000)


class BookLocation(models.Model):
    user = models.ForeignKey(User, verbose_name='User',
                             on_delete=models.CASCADE)
