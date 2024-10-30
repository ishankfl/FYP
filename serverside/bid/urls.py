from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenVerifyView
urlpatterns = [
    path('api/bid/', AddBid.as_view()),
    path('api/get/', GetBid.as_view()),
    path('api/addcomment/', CommentPostView.as_view()),
    path('api/addcomment/', CommentPostView.as_view()),
]
