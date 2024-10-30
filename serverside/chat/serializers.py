

from rest_framework import serializers
from account.serializers import CustomerSerializer, ServiceProviderSerializer, UserSerializer
from booking.models import Book
from services.serializers import ServicesSerializers, ServicesSerializers
from django.db import models
from rest_framework import serializers
from .models import ChatModel

class ChatSerializer(serializers.ModelSerializer):

    class Meta:
        model = ChatModel
        fields ='__all__'
