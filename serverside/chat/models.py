from django.db import models

# Create your models here.
class ChatModel(models.Model):
    chat_groupName=models.CharField(max_length=20,default=0)
    sender = models.CharField(max_length=100, default='')
    message = models.TextField(null=True, blank=True)
    receiver = models.CharField(null=True, blank=True, max_length=50)
    timestamp = models.DateTimeField(auto_now_add=True)

