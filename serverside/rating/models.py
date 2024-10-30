from django.db import models

# Create your models here.
from django.db import models
from django.conf import settings
from account.models import User
class Rating(models.Model):
    provider = models.ForeignKey(User, on_delete=models.CASCADE, related_name="review_provider")
    reviewer = models.ForeignKey(User, on_delete=models.CASCADE, related_name='reviewer')
    ratings = models.DecimalField(max_digits=5, decimal_places=2, null=False, blank=False)
    review = models.TextField(null=False, blank=False)
    date = models.DateTimeField(auto_now=True)


    def __str__(self):
        return f"{self.reviewer.full_name} - {self.provider.full_name}"