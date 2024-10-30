from rest_framework import serializers
from account.models import FavoriteProvider, FavoriteProviderr
from account.serializers import CustomerSerializer, ServiceProviderSerializer, UserSerializer
from booking.models import Book
from services.serializers import ServicesSerializers, ServicesSerializers
from django.db import models
from rest_framework import serializers
from .models import Book
class FavoriteProviderSerializer(serializers.ModelSerializer):
    to_user=UserSerializer()
    by_user=UserSerializer()
    class Meta:
        model = FavoriteProviderr
        fields = '__all__'

class BookSerializer(serializers.ModelSerializer):
    by = CustomerSerializer()
    to = ServiceProviderSerializer()
    service = ServicesSerializers()  # Make sure to replace 'ServicesSerializers' with the actual serializer for your 'Services' model
    # favorite_provider = FavoriteProviderSerializer(many=True, read_only=True, source='by.favoriteprovider_set')

    class Meta:
        model = Book
        # fields =['status','by','to','service','location','booking_start_date_time','booking_end_date_time','status']
        fields ='__all__'
