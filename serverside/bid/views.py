import datetime
from rest_framework.views import APIView
from account.models import Customer, ServiceProvider, User
from bid.models import Bid, Comment
from bid.serializers import BidSerializers, CommentSerializers
from booking.models import Book
from booking.serializers import BookSerializer
from services.models import Services
from account.serializers import ServiceProviderSerializer
from rest_framework.response import Response
from rest_framework import status
from rest_framework.permissions import IsAuthenticated 


# Create your views here.
class AddBid(APIView):
    def get(self,request):
        user=request.user
        if user.is_authenticated:
          obj=User.objects.get(email=user)

          bid_obj=Bid.objects.filter(user=User.objects.get(email=user))
          serializers=BidSerializers(bid_obj,many=True)
          return Response({'data':serializers.data,'success':1},status=status.HTTP_201_CREATED)
        

    # permission_classes = [IsAuthenticated]
    def post(self, request):
            user = request.user
            if user.is_authenticated:
                  text_content = request.data.get('textcontent',None)
                  images = request.FILES.get('image',None)
                  service = request.data.get('service',None)
                  lon=request.data.get('lon',None)
                  lat=request.data.get('lat',None)
                  service_obj=Services.objects.get(id=service)
                  # user_profile = User.objects.get(user=user)
                  obj=Bid.objects.create(lon=lon,lat=lat ,user=user, text_content=text_content,image=images,service=service_obj)
                  bidobj=Bid.objects.filter(user=User.objects.get(email=request.user))
                  serializers=BidSerializers(instance=bidobj,many=True)
                  print(serializers.data)
                  return Response({'message': 'Bid created successfully','error':0,'data':serializers.data, }, status=status.HTTP_201_CREATED)
            return Response({'message': 'User is not authenticated please try again','errror':1}, status=status.HTTP_401_UNAUTHORIZED)
    
class GetBid(APIView):    
    def get(self, request):
      user = request.user
      if user.is_authenticated:
        sort = request.GET.get('sort', 'default')
        user = request.user
        if sort == 'default':
            posts = Bid.objects.filter(is_deleted=False).order_by('-timestamp')
        elif sort == 'new':
            posts = Bid.objects.filter(is_deleted=False).order_by('-timestamp')
        serializer = BidSerializers(posts, many=True,context={'request': request})
        return Response(serializer.data, status=status.HTTP_200_OK)
      else:
            return Response({'message': 'User is not authenticated please try again','errror':1}, status=status.HTTP_401_UNAUTHORIZED)

class CommentPostView(APIView):
    def get(self,request):
        user=request.user
        bid=request.GET.get('bidId')
        bidcomment_obj=Comment.objects.filter(bid=bid).order_by('-timestamp')

        serializer=CommentSerializers(bidcomment_obj,many=True)
        print(serializer.data)
        return Response({'data':serializer.data}, status=status.HTTP_200_OK)
    def post(self, request):
        try:
            post_id = request.data.get("bid")
            print(post_id)
            post = Bid.objects.get(id=post_id,is_deleted=False)
            user = request.user
            comment = request.data.get("textcontent")

            print(user)

            Comment.objects.create(user=user, bid=post, text=comment)
            comments_for_post = Comment.objects.filter(bid=post, is_deleted=False).order_by('-timestamp') 
            comments = CommentSerializers(comments_for_post, many=True) 

            return Response({"message":"Comment added Sucessfully!","status":201,"data":comments.data},status=status.HTTP_201_CREATED)

        except Exception as e:
            print(e)
            return Response({"message":"Comment Failed!","status":500},status=status.HTTP_500_INTERNAL_SERVER_ERROR)