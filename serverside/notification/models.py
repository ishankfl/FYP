from django.db import models

from account.models import User

# Create your models here.
class Notificationss(models.Model):
      title=models.CharField(max_length=200)
      sender=models.ForeignKey(User,on_delete=models.CASCADE, related_name='notificationsbyuser')
      rece=models.ForeignKey(User,on_delete=models.CASCADE, related_name='notificationstoreceiver')
      success=models.BooleanField(default=False)
      type=models.CharField(max_length=255, blank=True)
      body=models.CharField(max_length=200)
      url=models.CharField(max_length=200)
      notification_type=models.CharField(max_length=50)
      is_positive=models.BooleanField(default=False)
      time=models.DateTimeField(auto_created=True,null=True,blank=True)


class Mobile(models.Model):
      phone_key=models.CharField(max_length=500)
      user=models.ForeignKey(User,on_delete=models.CASCADE)
      device_name=models.CharField(max_length=200)
      is_loggedin=models.BooleanField(default=False)

class Announcement(models.Model):
      # user=models.ForeignKey(User,on_delete=models.CASCADE)
      title=models.CharField(max_length=100,default='')
      body=models.CharField(max_length=255,default='')

class Announce(models.Model):
      user=models.ForeignKey(User,on_delete=models.CASCADE)
      title=models.CharField(max_length=100,default='')
      body=models.CharField(max_length=255,default='')

