from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenVerifyView
urlpatterns = [
    path('api/payment/', PaymentView.as_view()),
    path('api/history/', PaymentHistoryView.as_view()),
    path('api/monthly/', MontlyIncomeView.as_view()),
#     path('api/get/', GetBid.as_view()),
]
