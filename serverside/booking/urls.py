from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenVerifyView
urlpatterns = [

    path('api/booking-fetch/', AdminView.as_view()),
    path('api/provideravailability/', ProviderAvailability.as_view()),
    path('api/booking/', BookApi.as_view()),
    path('api/pending_request/', RequestedPendingBooking.as_view()),
    path('api/accept_request/', AcceptRequest.as_view()),
    path('api/cancelbook/', CancelBooking.as_view()),
    path('api/chattinglist/', ChatList.as_view()),
    path('api/homeview/', ProviderHomeView.as_view()),
    path('api/reschedule/', ReschuduleBooking.as_view()),
    path('api/makecomplete/',CompleteBooking.as_view()),
    

]
