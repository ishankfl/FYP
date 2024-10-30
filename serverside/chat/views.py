from django.shortcuts import render
from rest_framework.views import APIView

from account.models import Customer, ServiceProvider, User
from account.serializers import UserSerializer
from booking.models import Book
from chat.models import ChatModel
from django.db.models import Q

from chat.serializers import ChatSerializer
from rest_framework.response import Response
from rest_framework import status

# Create your views here.
class ChatMessageView(APIView):
      def get(self,request):
            try:
                  if request.user.is_authenticated:
                        getid=User.objects.get(email=request.user).id
                        chat_obj=ChatModel.objects.filter(Q(sender=getid) | Q(receiver=getid))
                        serializers=ChatSerializer(chat_obj,many=True)
                        return Response({'data':serializers.data},status=status.HTTP_200_OK)
                  else:
                        return Response({'error':'User is not autheticated , Re login'},status=status.HTTP_401_UNAUTHORIZED)                  
            except User.DoesNotExist:
                  return Response({'error':'Error to fetching data , Re login'},status=status.HTTP_401_UNAUTHORIZED)    
            except:
                  return Response({'error':'Internal Server Error'},status=status.HTTP_500_INTERNAL_SERVER_ERROR)    


from django.db.models import Max
from django.db.models import Max
from django.db.models import Max
from django.db.models import Max, F
from django.db.models import Subquery, OuterRef
from django.db.models.functions import Coalesce


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
            array=[]
            latest_chat=ChatModel.objects.all()
            for each in all_users_data:
                 for chat in latest_chat:
                      if(each.id == int(chat.sender) ):
                            item=({'userlist':{
                                'chat':chat.message,
                                'user': f'{UserSerializer(each).data}'}})
                            array.append(item)

            # print(latest_chat)



            return  Response({"data":array})
