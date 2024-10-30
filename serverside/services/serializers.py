from rest_framework import serializers
from account.models import ServiceProvider, User
from account.serializers import UserSerializer

from services.models import Services


class ServicesSerializers(serializers.ModelSerializer):
    class Meta:
        model = Services
        fields = '__all__'


class ServiceProviderSerializers(serializers.ModelSerializer):
    class Meta:
        model = ServiceProvider
        fields = '__all__'
class FetchServiceProviderAll(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:

        model = ServiceProvider
        fields = '__all__'
