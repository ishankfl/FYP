import datetime
from rest_framework.views import APIView
from account.models import Customer, FavoriteProvider, FavoriteProviderr, ServiceProvider, User
from booking.models import Book, CancelBook
from booking.serializers import BookSerializer, FavoriteProviderSerializer
from notification.models import Mobile
from services.models import Services
from account.serializers import UserSerializer
from rest_framework.response import Response
from rest_framework import status
from notification.views import send_notification

from django.db.models import Q
class AdminView(APIView):
    def get(self, request, *args, **kwargs):
        obj=Book.objects.all()
        serialzier=BookSerializer(obj,many=True)
        return Response(serialzier.data,status=status.HTTP_200_OK)

class BookApi(APIView):

    def get(self, request, *args, **kwargs):
        print("Booking get")
        user=request.user
        if user.is_authenticated:
            print(user)
            user_type=''
            user_obj=User.objects.get(email=user)
            try:
                user_type='customer'
                obj=Customer.objects.get(user=user_obj)
            except:  # noqa: E722
                user_type='provider'
                obj=ServiceProvider.objects.get(user=user_obj)
            if user_type=='customer':
                booking_obj=Book.objects.filter(by=obj)
            elif user_type=='provider':
                booking_obj=Book.objects.filter(to=obj)
            print(user_type)
            serializers=BookSerializer(booking_obj,many=True)
            array=[]
            for each in serializers.data:
    #              by_user = models.ForeignKey(User, blank=True,on_delete=models.CASCADE,related_name='FavoriteBy')
    # to_user   print
                print(each['to']['user']['id'])
                to_userr=User.objects.get(id=each['to']['user']['id'])
                print(to_userr)
                print(user)
                try:
                    object_favorite=FavoriteProviderr.objects.get(by_user=user,to_user=to_userr)
                    each['favorite_provider']=FavoriteProviderSerializer(object_favorite).data

                    print(each['favorite_provider'])
                except FavoriteProviderr.DoesNotExist:
                    each['favorite_provider']=None            
                # print(each)
                array.append(each)
            return  Response({'success':1, "data":array},status=status.HTTP_200_OK)
        else:
            return Response(
                {'error':'1','message':"Token is expired"},status=status.HTTP_401_UNAUTHORIZED
            )
    def post(self, request, *args, **kwargs):
        print("Booking post")

        if request.user.is_authenticated:
            try:
                print(request.data)
                userobj=User.objects.get(email=request.user)
                user=Customer.objects.get(user=userobj) 
                provider=request.data['provider']
                booking_date = request.data['booking_date']
                expected_time = request.data['expected_hours']
                location=request.POST.get('location',None)
                longitude=request.POST.get('longitude',None)
                latitude=request.POST.get('latitude',None)
                service=request.POST.get('service',2)
                provider_obj=ServiceProvider.objects.get(id=provider)
                start_date_time = datetime.datetime.strptime(booking_date, '%Y-%m-%d %H:%M:%S')
                expected_duration = datetime.timedelta(hours=int(expected_time))
                end_date_time = start_date_time + expected_duration
                if(provider is not None and start_date_time is not None and expected_time is not None):
                        existing_bookings = Book.objects.filter(to=provider_obj,booking_start_date_time__lt=end_date_time,booking_end_date_time__gt=start_date_time)                # print(start_date_time)
                        if existing_bookings.exists():                   
                            return Response([{'message':'You cannot book this user','available':0,'error':'1'}])
                        else:
                            obj=Book.objects.create(by=user,service=Services.objects.get(id=service),to=provider_obj,location=location,longitude=longitude,latitude=latitude, status='pending',booking_start_date_time=start_date_time,expected_hour=expected_time,booking_end_date_time=end_date_time)    
                            obj.save()  
                            booking_data=Book.objects.filter(by=user)
                            serializer=BookSerializer(booking_data,many=True)
                            # print(serializer.data)
                            print("Booking success")
                            token_obj = Mobile.objects.filter(user=obj.to.user)
                            print(token_obj)
                            array=[]
                            for i in token_obj:
                                array.append(i.phone_key)
                            print(array)
                            response = send_notification(
    request=request,
    title="Booking Request",
    body=f"{obj.by.user.full_name} send you a booking request",
    devices=array,  # This should be the list of device identifiers the notification is to be sent to
    image_url=str(obj.by.user.profile.path if obj.by.user.profile else ''),  # Converts the profile path to a string for the image URL
    is_positive=True,  # Indicates the nature of the notification
    typeof="booking",  # Specifies the type of the notification
    userBy=obj.by.user,  # The user initiating the booking request
    userTo=obj.to.user  # The recipient of the booking request
)

                           # response = send_notification(request,"Bookin Request",f"{obj.by.user.full_name} send you a bookin request",array,obj.by.user.profile)
                            return Response({'message':'Processed to booking process','available':1,'data':serializer.data})
                else:
                    return Response({'error':1,'message':'Please provide all needed details'})
            except User.DoesNotExist:
                 return Response({'error':'1','message':"Please Renew your token"},status=status.HTTP_401_UNAUTHORIZED)


        else:
            return Response(
                {'error':'1','message':"Token is expired"},status=status.HTTP_401_UNAUTHORIZED
            )
            # Book.objects.create(service_type=)
class ProviderAvailability(APIView):
    # permission_classes=[]
    # authentication_classes=[]
    def get(self,request,*args, **kwargs):
        provider=(request.GET.get('provider',None))
        start_date_time=request.GET.get('start_time_date',None)
        expected_time=request.GET.get('expected_hours',None)

        print("Provider :",provider)
        print("start time :",start_date_time)
        print("expected :",int(expected_time)+1)

        # Convert start_date_time_str to a datetime object
        start_date_time = datetime.datetime.strptime(start_date_time, '%Y-%m-%d %H:%M:%S')

        # Convert expected_time_hours to timedelta object (representing duration)
        expected_duration = datetime.timedelta(hours=int(expected_time)+1)
        end_date_time = start_date_time + expected_duration
        if(provider is not None and start_date_time is not None and expected_time is not None):
                existing_bookings = Book.objects.filter(to=provider,booking_start_date_time__lt=end_date_time,booking_end_date_time__gt=start_date_time,)                # print(start_date_time)
                if existing_bookings.exists():                   
                    return Response([{'message':'You cannot book this user. He is already booked on that time','available':0,'error':'0'}])
                else:                   
                    return Response([{'message':'Processed to booking process','available':1,}])
        else:
            return Response({'error':1,'message':'Please provide all needed details'})


class RequestedPendingBooking(APIView):
     permission_classes=[]
     authentication_classes=[]
     def get(self,request,*args, **kwargs):
        try:
            user_obj=User.objects.get(id=2)
            provider_obj=ServiceProvider.objects.get(user=user_obj)
            bookin_obj=Book.objects.filter(to=provider_obj,status='pending')
            serializer=BookSerializer(bookin_obj)
            return Response({'error':1,'message':'Verify you tokem','data':serializer.data},status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({'error':1,'message':'Verify you tokem'},status=status.HTTP_401_UNAUTHORIZED)


class CancelBooking(APIView):
    def post(self, request,*args, **kwargs):
        if request.user.is_authenticated:
            cancel_reason = request.POST.get('cancel_reason')
            cancel_reason=""
            book_id = request.POST.get('book_id')
            book_obj=Book.objects.get(id=book_id)
            book_obj.status='canceled'
            book_obj.save()
            token_obj = Mobile.objects.filter(user=book_obj.by.user)
            print(token_obj)
            array=[]
            for i in token_obj:
                array.append(i.phone_key)
            if request.user.user_type=='customer':
                name=book_obj.by.user.full_name
            else:
                name=book_obj.to.user.full_name

            
            booking_canceled_response = send_notification(
                request=request,
                title="Booking Canceled",
                body=f"You booking is canceled by {name}",
                is_positive=False,  # Assuming cancellation is considered negative
                typeof="booking",
                userBy=book_obj.by.user,
                userTo=book_obj.to.user,
                devices=array,  # Assuming 'array' is defined earlier as the target devices
                image_url=str(book_obj.to.user.profile.path)
            )


            CancelBook.objects.create(book_id=book_obj, cancel_reason=cancel_reason)
            return Response({'success':1,'error':0,'message':'Successfully Canceled booking'})

        else:
            return Response({'error':1,'message':'Token Expired'})
class AcceptRequest(APIView):
    def post(self, request,*args, **kwargs):
        if request.user.is_authenticated:
            book_id = request.POST.get('book_id')
            book_obj=Book.objects.get(id=book_id)
            book_obj.status='confirmed'
            book_obj.save()
            token_obj = Mobile.objects.filter(user=book_obj.by.user)
            print(token_obj)
            array=[]
            for i in token_obj:
                array.append(i.phone_key)
            response=send_notification(request=request,title="Booking Accept",body=f"You booking is accepted by {book_obj.to.user.full_name}",devices=array,image_url=str(book_obj.to.user.profile),is_positive=True,typeof="booking",userBy=book_obj.to.user,userTo=book_obj.by.user)
           # response = send_notification(request,"Booking Accepted",f"You booking is accepted by {book_obj.to.user.full_name}",array,str(book_obj.to.user.profile.path),"Accept Booking",book_obj.by.user,book_obj.to.user,True )#typeof,userBy,userTo,is_positive
            print(response)
            # CancelBook.objects.create(book_id=book_id, cancel_reason=cancel_reason)
            return Response({'success':1,'error':0,'message':'Successfully Accepted book booking'})
        else:
            return Response({'error':1,'message':'Token Expired',})

class ReschuduleBooking(APIView):
    def post(self, request,*args, **kwargs):
        if request.user.is_authenticated:
            book_id = request.data['book_id']
            booking_date = request.data['booking_date']
            expected_time = request.data['expected_hours']
            print(booking_date)
            print(expected_time)
            print(book_id)
            start_date_time = datetime.datetime.strptime(booking_date, '%Y-%m-%d %H:%M:%S')
            expected_duration = datetime.timedelta(hours=int(expected_time))
            # Convert expected_time_hours to timedelta object (representing duration)


            expected_duration = datetime.timedelta(hours=int(expected_time)+1)
            end_date_time = start_date_time + expected_duration
            book_obj=Book.objects.get(id=book_id)
            provider=book_obj.to
            existing_bookings = Book.objects.filter(to=provider,booking_start_date_time__lt=end_date_time,booking_end_date_time__gt=start_date_time,)                # print(start_date_time)
            if existing_bookings.exists():  
                print("Exist")                 
                return Response({'message':'You cannot book this user. He is already booked on that time','error':1})
            else:                   
                end_date_time = start_date_time + expected_duration
                book_obj=Book.objects.get(id=book_id)
                book_obj.booking_start_date_time=start_date_time
                book_obj.booking_end_date_time=end_date_time
                book_obj.expected_hour = expected_time
                book_obj.status='pending'
                book_obj.save()
                # CancelBook.objects.create(book_id=book_id, cancel_reason=cancel_reason)
                return Response({'error':0,'message':'Successfully Reschedule Booking','success':1})
        else:
                return Response({'error':1,'message':'Token Expired'})

class CompleteBooking(APIView):
    def post(self, request,*args, **kwargs):
        if request.user.is_authenticated:
            book_id = request.POST.get('book_id')
            book_obj=Book.objects.get(id=book_id)
            book_obj.status='completed'
            book_obj.is_complete=True
            book_obj.save()
            token_obj = Mobile.objects.filter(user=book_obj.by.user)
            print(token_obj)
            array=[]
            for i in token_obj:
                array.append(i.phone_key)
            
            booking_canceled_response = send_notification(
                request=request,
                title="Booking Completed",
                body=f"You booking is completed. Please do payment for services",
                is_positive=True,  # Assuming cancellation is considered negative
                typeof="booking",
                userBy=book_obj.by.user,
                userTo=book_obj.to.user,
                devices=array,  # Assuming 'array' is defined earlier as the target devices
                image_url=str(book_obj.to.user.profile.path)
            )
            # CancelBook.objects.create(book_id=book_id, cancel_reason=cancel_reason)
            return Response({'error':0,'message':'Book completed successfully','success':1})
        else:
            return Response({'error':1,'message':'Token Expired'})

class ChatList(APIView):
      def get(self, request, *args, **kwargs):
        user=(request.user)
        print(user)
        if user.is_authenticated:
            user_type=''
            user_obj=User.objects.get(email=user)
            try:
                user_type='customer'
                obj=Customer.objects.get(user=user_obj)
            except:
                user_type='provider'
                obj=ServiceProvider.objects.get(user=user_obj)
            if user_type=='customer':
                booking_obj=Book.objects.filter(Q(status='confirmed') | Q(status='completed'),is_paid=False,by=obj).values_list('to__user', flat=True).distinct()
            elif user_type=='provider':
                booking_obj=Book.objects.filter(Q(status='confirmed') | Q(status='completed'),is_paid=False,to=obj).values_list('by__user', flat=True).distinct()
            all_users_data = User.objects.filter(pk__in=booking_obj)

            print(all_users_data)
            serializers=UserSerializer(all_users_data,many=True)
            return  Response({"data":serializers.data})

class ProviderHomeView(APIView):
        def get(self, request, *args, **kwargs):
            if request.user.is_authenticated:
                # Get count of new requests for the specific user
                new_requests_count = Book.objects.filter(to=ServiceProvider.objects.get(user=request.user), status='pending').count()

                # Get count of accepted requests for the specific user
                accepted_requests_count = Book.objects.filter(to=ServiceProvider.objects.get(user=request.user), status='confirmed').count()

                # Get count of completed requests for the specific user
                completed_requests_count = Book.objects.filter(to=ServiceProvider.objects.get(user=request.user), status='completed').count()

                data = {
                    'new_requests_count': new_requests_count,
                    'accepted_requests_count': accepted_requests_count,
                    'completed_requests_count': completed_requests_count,
                }

                return Response(data)
            
            return Response({'error':1,'message':'Token Expired'})


# class EmergencyBookingServiceProviderList(APIView):
#     def post(self, request):
#         booking=Book.objects.filter()
#         if request.user.is_authenticated:
#             booking_date = datetime.datetime.now()
#             expected_time =3
#             start_date_time = datetime.datetime.strptime(booking_date, '%Y-%m-%d %H:%M:%S')
#             expected_duration = datetime.timedelta(hours=int(expected_time))
#             expected_duration = datetime.timedelta(hours=int(expected_time)+1)
#             end_date_time = start_date_time + expected_duration
#             # provider=request.data['[]']
#             provider=ServiceProvider.objects.all()
#             existing_bookings = Book.objects.filter(to__in=provider,booking_start_date_time__lt=end_date_time,booking_end_date_time__gt=start_date_time,)                # print(start_date_time)
#             if existing_bookings.exists():  
#                 print("Exist")                 
#                 return Response({'message':'You cannot book this user. He is already booked on that time','error':1})
#             else:
#                 return Response(['plist'])                 
