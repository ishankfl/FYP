from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenVerifyView
urlpatterns = [
#     path('api/addbid/', AddBid.as_view()),
#     path('api/chatmessage/', ChatMessageView.as_view()),
    path('api/logout/', Logout.as_view()),
    path('api/get-notification/', NotificationView.as_view()),
    path('api/make-announcement/', MakeAnnouncementView.as_view()),
]

