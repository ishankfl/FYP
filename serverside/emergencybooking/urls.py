from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenVerifyView
urlpatterns = [
#     path('api/addbid/', AddBid.as_view()),
#     path('api/chatmessage/', ChatMessageView.as_view()),
    path('api/serviceproviders/', EmergencyBookingServiceProviderList.as_view()),
]

