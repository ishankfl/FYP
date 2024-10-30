from django.urls import path
from .views import *
from rest_framework_simplejwt.views import TokenVerifyView
urlpatterns = [
    path('api/customer/', CustomerSignUpView.as_view(), name='customer_signup'),
    path('api/service-provider/', ServiceProviderSignUpView.as_view(),
         name='serviceprovider_signup'),
    path('api/login/', UserLoginTokenView.as_view(), name='user_login'),
    path('api/tokenverify/', TokenVerifyView.as_view()),
    path('api/otp/', OTPView.as_view()),
    path('api/image/', TryTwoImage.as_view()),
    path('api/userprofile/', UserProfile.as_view()),
    path('api/adminlogin/', AdminLogin.as_view()),
    path('api/forgotpasswordgetcode/', ForgotPasswordView.as_view(), name='forgot_password'),
    path('api/changepassword/', ChangePasswordView.as_view(), name='forgot_password'),
    path('api/verifyprovider/', VerifyProviders.as_view(), name='forgot_password'),
    path('api/favorite/', MakeFavorite.as_view(), name='forgot_password'),
    path('api/fetchuser/', FetchUsers.as_view(), name='forgot_password'),
    # path('api/fetchproviderbyservices/', .as_view())
    # path('api/viewdata/', ViewProfile.as_view()),

]
