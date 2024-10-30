import datetime
from django.shortcuts import render
from rest_framework.views import *

from account.models import ServiceProvider
from account.serializers import ServiceProviderSerializer
from booking.models import Book
from services.models import Services
# Create your views here.
class EmergencyBookingServiceProviderList(APIView):
    def get(self, request):
        if request.user.is_authenticated:
            # Extract required data from the request
            start_date_time = datetime.datetime.now()
            print(start_date_time)
            # print("Current date: " + start_date_time)
            expected_time = 2
            # start_date_time = datetime.datetime.strptime(booking_date, '%Y-%m-%d %H:%M:%S')
            expected_duration = datetime.timedelta(hours=int(expected_time))
            end_date_time = start_date_time + expected_duration

            # Get the list of all service providers
            service=Services.objects.get(service_name=request.GET['service'])
            providers = ServiceProvider.objects.filter(services_offered=service)

            # Filter out providers who are not available at the given time slot
            available_providers = []
            for provider in providers:
                print(provider)
                existing_bookings = Book.objects.filter(
                    to=provider,
                    booking_start_date_time__lt=end_date_time,
                    booking_end_date_time__gt=start_date_time,
                    status='confirmed'
                )
                print('Bookings - ',existing_bookings)
                if not existing_bookings.exists():
                    print("Available")
                    available_providers.append(ServiceProviderSerializer(provider).data)
                  #   available_providers.append(provider)

            
            print(available_providers)
            print(request.GET['service'])
            return Response({'available_providers':available_providers})
        else:
            return Response({'message': 'User is not authenticated'}, status=status.HTTP_401_UNAUTHORIZED)
