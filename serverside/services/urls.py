from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenVerifyView
urlpatterns = [
    path('api/fetchservices/', FetchServices.as_view(), name='customer_signup'),
    path('api/fetchservicesprovider/', FetchProviderAndServices.as_view(),
         name='customer_signup'),
    path('api/fetchproviderbyservices/', FetchProviderbyServices.as_view()),
    path('api/services/', ServiceView.as_view()),
    path('api/providers/', FetchAllProvider.as_view(),
         ),

]
