from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenVerifyView
urlpatterns = [

    path('api/rateprovider/',AddReview.as_view()),

]