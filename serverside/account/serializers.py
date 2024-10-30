from rest_framework import serializers
from .models import Customer, FavoriteProviderr, ServiceProvider, User
from rest_framework_simplejwt.serializers import TokenObtainPairSerializer

from django.utils import timezone


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'full_name', 'email','city',
                  'phonenumber', 'user_type', 'password','profile','location']
class UpdateUserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        
        fields = ['id','username', 'full_name', 'email','city',
                  'phonenumber', 'user_type', 'password','profile']



class CustomerSerializer(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:
        model = Customer
        fields = ['user', 'date', 'verify_status']


class ServiceProviderSerializer(serializers.ModelSerializer):
    user = UserSerializer()

    class Meta:
        model = ServiceProvider
        fields = ['id','user', 'experience',
                  'certificate', 'services_offered']
        read_only_fields = ['id']

    def create(self, validated_data):
        user_data = validated_data.pop('user')
        certificate_data = validated_data.pop('certificate')

        user_instance = User.objects.create(**user_data)

        # Extract the image file from the certificate data
        certificate_image = certificate_data.pop('image')

        certificate_instance = ServiceProvider.objects.create(user=validated_data.pop(
            'user'), experience=validated_data.pop('experience'), certificate=certificate_image, services_offered='Provider')

        experience = validated_data['experience']

        return {
            'user': user_instance,
            'experience': experience,
            'certificate': certificate_instance,
        }


class UserTokenPairSerializer(TokenObtainPairSerializer):
    def validate(self, attrs):
        print("inside valideate ",attrs)
        data = super().validate(attrs)
        data['username'] = self.user.username
        data['groups'] = self.user.groups.values_list('name', flat=True)
        data['user_type'] = self.user.user_type
        return data

    @classmethod
    def get_token(cls, user):
        print(user.last_login)
        token = super().get_token(user)
        user.last_login = timezone.now()
        print(cls)
        print("Clas")
        # Mobile.objects.create( )
        user.save()
        print(user.last_login)
        return token

class FavoriteProviderrSerializer(serializers.ModelSerializer):
    by_user = UserSerializer()
    to_user = UserSerializer()

    class Meta:
        model = FavoriteProviderr
        fields = ['by_user', 'to_user', 'is_favorit', 'timestamp']