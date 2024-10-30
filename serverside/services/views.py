from django.shortcuts import render
from rest_framework.views import Response
from rest_framework.views import APIView

from account.models import Customer, ServiceProvider
from account.serializers import CustomerSerializer
from rating.models import Rating
from services.serializers import FetchServiceProviderAll, ServiceProviderSerializers, ServicesSerializers
from .models import Services
# Create your views here.
from rest_framework import status
from django.db.models import Avg


class FetchServices(APIView):
    def get(self, request, *args, **kwargs):
        services = Services.objects.all()
        serializer = ServicesSerializers(services, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class FetchProvider(APIView):
    def get(self):
        services = ServiceProvider.objects.all()
        serializer = ServiceProviderSerializers(services, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class FetchProviderAndServices(APIView):
    def get(self, request, *args, **kwargs):
        provider = ServiceProvider.objects.all()
        provider_serializer = ServiceProviderSerializers(provider, many=True)
        services = Services.objects.all()
        service_serializer = ServicesSerializers(services, many=True)
        return Response({'provider': provider_serializer.data, 'services': service_serializer})


# class FetchProviderAndServices(APIView):
#       def get(self,request,*args, **kwargs):

class FetchAllProvider(APIView):
    def get(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            provider = ServiceProvider.objects.all()
            provider_serializer = FetchServiceProviderAll(provider, many=True)
            return Response(provider_serializer.data, status=status.HTTP_200_OK)
        else:
            return Response({'error': 1,'message': 'You are not authenticated'}, status=status.HTTP_401_UNAUTHORIZED)
class FetchProviderbyServices(APIView):
    def get(self,request,*args, **kwargs):
        services=request.GET.get('service',None)
        print(services)
        if(services is not None):
            serviceobj=Services.objects.get(id=services)
            if serviceobj:
                provider=ServiceProvider.objects.filter(services_offered=serviceobj,verification_status=True )
                provider_serializer = FetchServiceProviderAll(provider, many=True)
                print(provider_serializer.data)
                array=[]
                for each in provider_serializer.data:
                    if each.user.is_verifed:
                        print(each)
                        provider_id=(each['id'])
                        provider_obj=ServiceProvider.objects.get(id=provider_id)
                        ratings = Rating.objects.filter(provider=provider_obj.user.id)
                        try:

                            # Calculate the average rating
                            average_rating = ratings.aggregate(avg_rating=Avg('ratings'))['avg_rating']
                            each['averagerating']=float(average_rating)

                        except:
                            average_rating="1.10000000000"
                            each['averagerating']=1.0
                        array.append(each)
                        print("averate rating")
                        print(average_rating)
                print("array")

                return Response(array)
        return Response({"error"})
class ServiceView(APIView):
    def get(self, request, *args, **kwargs):
        services = Services.objects.all().order_by('id')
        serializer = ServicesSerializers(services, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def put(self, request, *args, **kwargs):
        # print(request.use)
        print(request.data)
        print(request.FILES)
        if request.POST.get('id') is not None:
            services=Services.objects.get(id=request.POST.get('id'))
            services.service_name=request.POST.get('service_name')
            if request.FILES.get('image') is not None: 
                # services = Services.objects.get(id=request.POST.get('id'))
                services.image = request.FILES.get('image')
            services.save()
            
            print("Iddddddddddddd",request.POST.get('id'))
        return Response(status=status.HTTP_200_OK)

    def delete(self, request, *args, **kwargs):
            print(request.user)
            print(request.data)
            print(request.GET.get('id'))
            # if request.user.user_type=='admin':
            services=Services.objects.get(id=request.GET.get('id')).delete()
            
            return Response(status=status.HTTP_200_OK)
            # else:
                # return Response({'error': 1,'message': 'You are not authorized to delete this service'}, status=status.HTTP_401_UNAUTHORIZED)
            # return Response({'error': 1,'message': 'You are not authorized to delete this service'}, status=status.HTTP_401_UNAUTHORIZED)
        