import time
from django.db import models as model
from django.utils.functional import cached_property
from django.utils.html import format_html
# Create your models here.
from django.db import models
from django.contrib.auth.models import AbstractUser, PermissionsMixin, BaseUserManager
from services.models import Services
from django.utils.translation import gettext_lazy as _


def upload_to(instance, filename):
    username = instance.username if instance.username else 'unknown_user'
    filename = str(filename).split('.')[-1]
    # Change 'profiles' to the desired subdirectory
    return f'profiles/{username}_.{filename}'

def upload_to_empty(self,filename):
    # username = instance.username if instance.username else 'unknown_user'
    filename = str(filename).split('.')[-1]
    # Change 'profiles' to the desired subdirectory
    return f'emptyimage/empyt.{filename}'



class User(AbstractUser, PermissionsMixin):
    full_name = models.CharField(
        max_length=255, blank=False, null=False, default="")
    username = models.CharField(
        max_length=255,
        unique=False, null=True)
    phonenumber = models.CharField(max_length=15, blank=False, default='')
    city = models.CharField(max_length=15, blank=False, default='')
    location = models.CharField(max_length=255, blank=True, default='',)
    profile = models.ImageField(
        verbose_name='profile', blank=True, upload_to=upload_to)
    email = models.EmailField(unique=True)

    USER_TYPE = [
        ("admin", "Admin"),
        ("customer", "Customer"),
        ("provider", "ServiceProvider"),
    ]
    user_type = models.CharField(
        max_length=20, choices=USER_TYPE, default='customer')
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username']
    

    def __str__(self):
        return f'{self.email}'

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self._meta.get_field('first_name').blank = True
        self._meta.get_field('last_name').blank = True
        # self.username = ''

        # Add your additional fields here

 
    def update_password(self, new_password):
        # Set the password for the user
        self.set_password(new_password)
        self.save()

class Customer(models.Model):
    user = models.OneToOneField(
        User, on_delete=models.CASCADE, verbose_name='cutomer_user')
    date = models.DateField(auto_now=True)
    verify_status = models.BooleanField(default=False)

    # class Meta:
    #     verbose_name = "Customer"
    total_services = models.IntegerField(default=0)

    class Meta:
        verbose_name = "Customer"

    def __str__(self):
        return f"{str(self.user.email)}"

class ServiceProvider(models.Model):
    def get_default_services_slug():
        try:
            return Services.objects.all()[0].slug
        except IndexError:
            return None
    user = models.OneToOneField(
        User, on_delete=models.CASCADE, verbose_name='provider_user')
    experience = models.CharField(max_length=200)
    certificate = models.FileField(blank=True)
    verification_status = models.BooleanField(
        default=False, verbose_name='is_verify')
    is_available = models.BooleanField(default=True)
    is_booked = models.BooleanField(default=False)
    services_offered = models.ForeignKey(
        Services,
        default=get_default_services_slug,
        on_delete=models.CASCADE,
        # limit_choices_to={'slug__in': [
        #     category.slug for category in Services.objects.all()]
        #   },
    )
    total_services = models.IntegerField(default=0,)

    class Meta:
        verbose_name = "Service Provider"

    def __str__(self):
        return f'{str(self.user.email)}'

    def save(self, *args, **kwargs):

        created = not self.pk  # Check if the instance is being created
        if created:
            # Increase the total providers for the associated service
            self.services_offered.total_providers += 1
            self.services_offered.save()
        if self.services_offered:
            # If services_offered is not None, retrieve the corresponding object
            # and assign it to the ForeignKey field
            self.services_offered = Services.objects.get(
                slug=self.services_offered.slug)

        super(ServiceProvider, self).save(*args, **kwargs)

    @cached_property
    def display_image(self):
        html = '<a href="{img}"><img src="{img}" style="height:100px;">'
        if self.certificate:
            return format_html(html, img=self.certificate.url)
        return format_html('<strong>There is no image for this entry.<strong>')
    display_image.short_description = 'Certificate'

class NullPictures(model.Model):
    image=models.ImageField(upload_to=upload_to_empty)


class FavoriteProvider(model.Model):
    by_user = models.ForeignKey(User, blank=True,on_delete=models.CASCADE,related_name='FavoriteBy')
    to_user=models.ForeignKey(User, blank=True,on_delete=models.CASCADE,related_name='FavoriteTo')
    is_favorit=models.BooleanField(default=True)
    timestamp=models.DateTimeField(auto_now_add=True)
    class Meta:
        verbose_name = "Favorite Provider"
        verbose_name_plural = "Favorite Providers"
        unique_together = ('by_user', 'to_user')
        ordering = ['-timestamp']

        
class FavoriteProviderr(model.Model):
    by_user = models.ForeignKey (User, blank=True,on_delete=models.CASCADE,related_name='ByUser')
    to_user=models.ForeignKey (User, blank=True,on_delete=models.CASCADE,related_name='ToUser')
    is_favorit=models.BooleanField(default=True)
    timestamp=models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{str(self.by_user.full_name)}  {str(self.to_user.full_name)}"
