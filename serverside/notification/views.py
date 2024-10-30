
# Create your views here.

from rest_framework.views import APIView


from rest_framework.response import Response
import firebase_admin
from firebase_admin import credentials
import json
import requests

from account.serializers import UserSerializer
from notification.models import  Announce, Mobile, Notificationss
from notification.serializers import AnnouncementSerializer, NotificationSerializer
from rest_framework.views import status


# from notification.serializers import NotificationSerializer
# from .models import Notification
class NotificationView(APIView):
      def get(self, request,*args, **kwargs):
            try:
                  print(request.user)
                  if request.user.is_authenticated:
                        # Filter payments based on the user's ID
                        instance = Notificationss.objects.filter(rece=request.user)
                        serializer=NotificationSerializer(instance,many=True)
                        announcement=AnnouncementSerializer(instance,many=True)

                        return Response(serializer.data, status=status.HTTP_200_OK)
                  else:
                        return Response({'error': 1,'message': 'You are not authenticated'}, status=status.HTTP_401_UNAUTHORIZED)
            except Exception as e:
                  print(e)
                  return Response({'error': 1,'message': 'Something went wrong'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class NotifyAll(APIView):
      def post(self,request):

            response=send_notification(request,"Tittle","body",[])
            return Response({'data':response.content})

def newitme(request=None):
       pass
def send_notification(request=None,title=None,body=None,devices=None,image_url=None,typeof=None,userBy=None,userTo=None,is_positive=None):
            print("Devices")
            print(devices)
            # Updated model fields are 'sender' and 'receiver'
            obj = Notificationss.objects.create(title=title, success=True, body=body, url=image_url, type=typeof, sender=userBy, rece=userTo,  is_positive=is_positive)
            # obj.save()
            image=str(image_url)
            # topic_id=request.POST.get('id',None)
            # body=request.POST.get('body',None)
            # title=request.POST.get('title',None)

            url = "https://fcm.googleapis.com/fcm/send"
            # topic = f"YOUR_TOPIC_NAME_{topic_id}"
            data = {
                   "data":{"imageurl":image},
                  "notification": 
                        {
                              "title": title, 
                              "body": body, 
                              "mutable_content": True,
                        },
                  "registration_ids": devices,
            }

            headers = {"Content-Type": "application/json", "Authorization": "key=AAAAa56TZuk:APA91bF4T5tN5I-J-0ds1ybRv0h_hWLhqfjaBElVfSVGGl8RNesrVCnUw19_xCT6sywgWW4nhaSevW_a_RrOYDcqSV7ckdMT5ye2k-cR-MxJS-Q5l72gv5ATL04xj0xvZ9MEFm47EdxK"}
            payload = json.dumps(data, default=int)
            print("Payload")
            print(payload)
            response = requests.post(url, headers=headers, data=payload)
            print("Successfully sent notification:", response.status_code)
            return Response({'data':response.content})


class Logout(APIView):
    def post(self,request,*args, **kwargs):
        user=request.user
        key=request.data['tokenString']
        print(key)
        dlt_object=Mobile.objects.filter(phone_key=key)
        print(dlt_object)
        dlt_object.delete()
        new_object=Mobile.objects.filter(phone_key=key)
        print(new_object)
        return Response({'success':1,'message':"Successfully logged out"},status=status.HTTP_200_OK)

class MakeAnnouncementView(APIView):
      def post(self,request,*args, **kwargs):
            data=request.data
            # user_data=UserSerializer(request.data).data
            # data['user']=user_data
            print(data)
            serilezer=Announce.objects .create(user_id=request.user.id,title=request.data['title'],body=request.data['description'])

            try:  
                  sfsdf=Mobile.objects.all().only('phone_key').distinct()
                  phone_key_list = [obj.phone_key for obj in sfsdf]

                  send_notification(devices=phone_key_list, title=request.data['title'],body=request.data['description'],)

            except Exception as e:
                  print(e)
                  return Response({'error':"faild to send notification"},status=status.HTTP_200_OK)
            # if(serilezer.is_valid()):
            #       serilezer.save()
            return Response({'success':1,'message':'Successfully send notification'},status=status.HTTP_200_OK)
            # else:
            #       print(serilezer.errors)
            #       return Response({'error':1,'message':'Error'},status=status.HTTP_400_BAD_REQUEST)
            
      def get(self,request):
            user=request.user
            serializer=Announce.objects.all()
            return Response(serializer.data, status=status.HTTP_200_OK)
            # try:
            #       announces=Announce.objects.filter(user_id=user.id)
            #       serializer=AnnouncementSerializer(announces,many=True)
            #       return Response(serializer.data, status=status.HTTP_200_OK)
            