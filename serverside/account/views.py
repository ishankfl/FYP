
# importing modules
from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import AllowAny
from rest_framework_simplejwt.views import TokenObtainPairView
from account.models import Customer, FavoriteProvider, FavoriteProviderr, ServiceProvider, User
from account.serializers import CustomerSerializer, FavoriteProviderrSerializer, UpdateUserSerializer, UserSerializer, UserTokenPairSerializer, ServiceProviderSerializer
from django.contrib.auth.hashers import make_password
import pyotp
from django.db import transaction
from account.utils import send_email, send_otp
from notification.models import Mobile
from services.models import Services


def fetch_services(request):
    services_list = list(Services.objects.all().values())
    servicenewlist = []
    for i in services_list:
        servicenewlist.append(i['service_name'])
        print(i['service_name'])
    # print(services_list)
    return servicenewlist


class CustomerSignUpView(APIView):
    def get(self, request, *args, **kwargs):
        customers = Customer.objects.all()
        serializer = CustomerSerializer(customers, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request, *args, **kwargs):
        user_data = request.data.get('user',None)
        # if user_data is None:
        #     return Response({'error':1,'message':'User field rerquired'})
        print(user_data.get('email',None))
        for each in  ['full_name', 'email', 'phonenumber', 'user_type', 'password','location']:
            print("each")
            if user_data.get(each,None) is None or request.data['user'][each]=="":
                return Response(
                        ( f"The field {each} cannot be empty.")

                )

        user_type = user_data.get('user_type')
        print(user_type)

        try:
            with transaction.atomic():
                user_obj = User.objects.get(email=user_data['email'])
                if user_obj.is_active:
                    return Response({"errors": "User already exists."}, status=status.HTTP_409_CONFLICT)

                user_obj.delete()
                user_serializer = UserSerializer(data=user_data)
                if user_serializer.is_valid():
                    user_serializer.save()
                    otp, seccode = send_otp(request,email= user_data['email'])
                    send_email((user_data['email']),otp,'OTP Email by BookMe'),

                    request.session['email'] = user_data['email']
                    return Response({
                        'verification_code': 'Enter verification code for successful registration.',
                        'email': user_data['email'],
                        'secret_code': seccode
                    })
                else:
                    return Response(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except User.DoesNotExist:

            user_serializer = UserSerializer(data=user_data)
            if user_serializer.is_valid():
                customer_serializer = CustomerSerializer(data=request.data)
                if user_type == 'customer' and customer_serializer.is_valid():
                    user_instance = user_serializer.save()
                    customer_serializer.save(user=user_instance)
                else:
                    user_instance = user_serializer.save()

                user_instance.is_active = False
                user_instance.password = make_password(user_instance.password)
                user_instance.save()
                otp, seccode = send_otp(request,email=[user_instance.email])
                return Response({
                    'verification_code': 'Enter verification code for successful registration.',
                    'email': user_instance.email,
                    'secret_code': seccode
                })
            else:
                return Response(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def put(self, request):
        print("put method called")


class ServiceProviderSignUpView(APIView):
    def get(self, request, *args, **kwargs):
        print(self.authentication_classes)
        providers = ServiceProvider.objects.all()
        serializer = ServiceProviderSerializer(providers, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def post(self, request, *args, **kwargs):
        image_file = request.FILES['certificate']
        profile=request.FILES['profile']
        service_type=request.data['service_type']
        service_offered = Services.objects.get(service_name=service_type)

        print(image_file)
        print(profile)
        print(image_file)
        email = request.data.get('email')
        print(email)
        user_instance = User.objects.get(email=email)
        user_instance.profile=profile
        user_instance.save()
        object = ServiceProvider.objects.create(user=user_instance, experience=request.data['experience'][0],
                                                certificate=image_file, services_offered=service_offered)
        if object:
            object.save()
            return Response({"success": "1","message":"Success" }, status=status.HTTP_200_OK)
        return Response({"success": "0","error":"1","message":"Server Error"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def put(self, request):
        print("putmethodcalled")


class UserLoginTokenView(TokenObtainPairView):
    permission_classes = (AllowAny,)
    serializer_class = UserTokenPairSerializer

    def post(self, request, *args, **kwargs):
        # Print the raw request data
        print("Raw request data:", request.data)

        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        # Accessing the validated data
        received_data = serializer.validated_data
        print("Received data:", received_data)

        # Continue with the default token creation process
        response = super().post(request, *args, **kwargs)
        # Optionally, you can print the token or any other information from the response
        token = response.data.get('access', None)
        if token:
            print("Generated token:", token)
            email=request.data['email']
            user_obj=User.objects.get(email=email)


        mobile_obj=Mobile.objects.create(
            phone_key= request.data['device_token'],
            device_name=  request.data['device_token'],
            is_loggedin=True,
            user=user_obj)
        mobile_obj.save() 

        return response

class OTPView(APIView):
    def post(self, request):
        otp = request.data['entered_otp']
        email = request.data['email']
        otp_key = request.data['secret_code']
        print(otp_key)
        print('email')
        print(otp_key)
        if otp_key is not None:
            context = {"success": "otp_correct", }
            totp = pyotp.TOTP(otp_key, interval=200)
            if totp.verify(otp):
                print("inside verification")
                user = User.objects.get(email=email)
                user.is_active = True
                user.save()
                try:
                    is_forgot_password=request.data['is_forgot_password']
                    if is_forgot_password=="is_forgot_password":
                        return Response({"success": "successful registration","is_forgot_password":"is_forgot_password", 'user_type': user.user_type, 'email': email, 'services': str(fetch_services(request))})
                    else:
                        return Response({"success": "successful registration", 'user_type': user.user_type, 'email': email, 'services': str(fetch_services(request))})
                except KeyError:
                    return Response({"success": "successful registration", 'user_type': user.user_type, 'email': email, 'services': str(fetch_services(request))})
            else:
                context = {"errors": "otp_error", }
        else:
            context = {"errors": "otp doesnt match"}

        return Response(context, status=status.HTTP_400_BAD_REQUEST)


class TryTwoImage(APIView):
    def post(self, request, *args, **kwargs):
        print(request.data)

    def get(self, request, *args, **kwargs):
        return Response("success")
# from rest_framework.permissions import IsAuthenticated
class UserProfile(APIView):
    # authentication_classes =[]
    # permission_classes =[]
    
    def get(self,request,*args, **kwargs):
        print(request.user)
        if request.user.is_authenticated:
            obj=User.objects.get(email=request.user)
            serizlizers=UpdateUserSerializer(obj)
            return Response({'data':f'{serizlizers.data}','success':1})
        else:
            return Response({'error':1,'message':"Token is expired"},status=status.HTTP_401_UNAUTHORIZED)
    # Yesle kunai user to role/username change garne
    def patch(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            try:
                print(request.data)
                id = request.user.id
                instance = User.objects.get(id=id)
                serializer = UpdateUserSerializer(instance, data=request.data, partial=True)
                serializer.is_valid(raise_exception=True)
                serializer.save()
                obj=User.objects.get(email=request.user)
                serizlizers=UpdateUserSerializer(obj)
                print(serializer.data)
                return Response({'data':f'{serizlizers.data}','success':1})
            except User.DoesNotExist:
                return Response(("User not found"), status=status.HTTP_404_NOT_FOUND)
            except Exception as e:
                print(e)
                return Response(("Something went wrong"), status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            return Response({"error":"Token Invalid"})

        # else:
        #     return Response({'error':1,'message':"User is not autheticated"},status=400)

class AdminLogin(APIView):
    def post(request,self,*args, **kwargs):
        return Response({'data':{'success':'1','message':"ksdfjlk"}},)


class FavoriteProviderView(APIView):
    def post(self, request, *args, **kwargs):
        try:
            user=request.user
            provider=request.data['provider']
            favorite_user_obj=FavoriteProviderr.objects.create(
                by_user=user, to_user=provider
            )
            favorite_user_obj.save()

        except User.DoesNotExist:
            return Response("Userser not found", status=status.HTTP_404_NOT_FOUND)

class ForgotPasswordView(APIView):
    def post(self, request, *args, **kwargs):
        email=(request.data['email'])
        try:
            user = User.objects.get(email=email)
        
            otp, seccode = send_otp(request)
            return Response({
                'success':'1',
                'verification_code': 'Enter verification code for successful registration.',
                'email': user.email,
                'secret_code': seccode
            })

        except User.DoesNotExist:
            return Response({'error':1,'message':'Please do signup first'},status=status.HTTP_404_NOT_FOUND)

class ChangePasswordView(APIView):
    def post(self, request, *args, **kwargs):   
        try:
            user = User.objects.get(email=request.data['email'])
            user.set_password(request.data['password'])
            user.save()
            return Response({'success':1,'message':'Password changed successfully'},status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({'error':1,'message':'Please do signup first'},status=status.HTTP_404_NOT_FOUND)


class VerifyProviders(APIView):
    def post(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            try:
                id=request.data['id']
                print(id)

                provider=ServiceProvider.objects.get(id=id)
                if(provider.verification_status == True):
                    provider.verification_status=False
                else:
                    provider.verification_status=True
                provider.save()
                print(provider.verification_status)
                provider.save()
                return Response({'success':1,'message':'Provider verified successfully','status':provider.verification_status},status=status.HTTP_200_OK) 

            except User.DoesNotExist:
                return Response({'error':1,'message':'Please do signup first'},status=status.HTTP_404_NOT_FOUND)
        else:
            return Response({'error':1,'message':'Token is expired'},status=status.HTTP_404_NOT_FOUND)

class MakeFavorite(APIView):
     def get(self, request, *args, **kwargs):
         try:
             user = request.user
             object=FavoriteProviderr.objects.filter(by_user=user)
             serializer=FavoriteProviderrSerializer(object,many=True)
             print(serializer.data)
             return Response(serializer.data,status=status.HTTP_200_OK)
         except User.DoesNotExist:
             return Response({'error':1,'message':'Please do signup first'},status=status.HTTP_404_NOT_FOUND)
         except Exception as e:
             print(e)
             return Response({'error':1,'message':'Some thing went wrong'},status=status.HTTP_500_INTERNAL_SERVER_ERROR)


     def post(self, request, *args, **kwargs):
        try:
            user = request.user
            provider_id = request.data.get('provider')
            state = request.data.get('is_favorite')

            if provider_id is None or state is None:
                return Response({'error': 1, 'message': 'Provider ID or state missing'}, status=status.HTTP_400_BAD_REQUEST)

            provider_obj = User.objects.get(id=provider_id)

            # Check if the provider is already in the user's favorite list
            favorite_user_obj = FavoriteProviderr.objects.filter(by_user=user, to_user=provider_obj).first()

            if favorite_user_obj:
                # If the entry already exists, update its is_favorit field
                favorite_user_obj.is_favorit = state
                favorite_user_obj.save()
            else:
                # If the entry does not exist, create a new one
                favorite_user_obj = FavoriteProviderr.objects.create(
                    by_user=user,
                    to_user=provider_obj,
                    is_favorit=state
                )

            if state:
                message = 'Provider added to favorites successfully'
            else:
                message = 'Provider removed from favorite list'

            return Response({'success': 1, 'message': message, 'state': state}, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({'error': 1, 'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({'error': 1, 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class FetchUsers(APIView):
    def get(self, request, *args, **kwargs):
        try:
            users = User.objects.all()
            serializer = UserSerializer(users, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({'error': 1, 'message': 'User not found'}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response({'error': 1, 'message': str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)