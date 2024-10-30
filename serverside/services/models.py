from django.db import models

# Create your models here.

from django.template.defaultfilters import slugify


class Services(models.Model):
    service_name = models.CharField(max_length=255, unique=True)
    slug = models.SlugField(verbose_name='slug', blank=True, unique=True)
    image = models.ImageField(blank=True)
    service_description = models.TextField(max_length=255)
    hourly_rate = models.IntegerField(verbose_name="Rate")
    is_available = models.BooleanField(default=True)
    total_providers = models.IntegerField(default=0)

    class Meta:
        verbose_name = "Service"

    def save(self, *args, **kwargs):
        self.s = slugify(self.service_name)
        super(Services, self).save(*args, **kwargs)

    def __str__(self):
        return self.service_name


class ReviewandRate(models.Model):
    service = models.OneToOneField(
        Services, on_delete=models.CASCADE, verbose_name='service')
    rate = models.IntegerField(blank=True)

    review = models.CharField(blank=True, max_length=1000)

    class Meta:
        verbose_name = 'ReviewAndReview'

# class Rate(models.Model):
#     service=models.OneToOneField(Services,on_delete=models.CASCADE,verbose_name='service')
#     rate=models.IntegerField(blank=True)
#     class Meta:
#         verbose_name='Rate'
