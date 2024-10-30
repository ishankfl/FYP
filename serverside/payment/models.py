from django.db import models

from booking.models import Book

# Create your models here.
class Payment(models.Model):
      amount=models.FloatField(null= True,blank=True,default=0.0)
      transaction_id=models.CharField(max_length=255)
      token=models.CharField(max_length=255)
      booking=models.ForeignKey(Book,on_delete=models.CASCADE)
      service_type=models.CharField(max_length=255)
      payment_type=models.CharField(max_length=255)
      payment_date=models.DateTimeField(auto_now=False, auto_now_add=False)
      
