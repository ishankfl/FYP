from django.db import models
from account.models import User
# from django.contrib.auth.models import User

from services.models import Services

def upload_to(instance, filename):
    username = instance.user if instance.user else 'unknown_user'
    image_name = str(filename).split('.')[-1]
#     filename = str(filename).split('.')[-1]
    # Change 'profiles' to the desired subdirectory
    return f'bid_images/{username}_{filename}.{filename}'

class Bid(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    service = models.ForeignKey(Services, on_delete=models.CASCADE)
    text_content = models.TextField()
    image = models.ImageField(upload_to=upload_to)
    timestamp = models.DateTimeField(auto_now_add=True)
    is_deleted = models.BooleanField(default=False)
    reports_count = models.IntegerField(default=0)
    lon = models.FloatField()
    lat = models.FloatField()
    location = models.CharField(max_length=100)
    
    def _str_(self):
        return f'{self.user.username} ${self.id}'    

# class Like(models.Model):
#     post = models.ForeignKey('Bid', on_delete=models.CASCADE, related_name='likes')
#     liked_by = models.ForeignKey('auth.User', on_delete=models.CASCADE, related_name='likes')
    
#     def _str_(self):
#         return self.liked_by.username + " " + self.post.user.username


class Comment(models.Model):
    bid = models.ForeignKey('Bid', on_delete=models.CASCADE, related_name='comments')
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='comments')
    text = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    is_deleted = models.BooleanField(default=False)
    
    def _str_(self):
        return self.user.username 