from rest_framework import serializers
from rating.models import Rating
from account.serializers import UserSerializer,ServiceProviderSerializer

class RatingSerializer(serializers.ModelSerializer):
    provider = UserSerializer (read_only=True)
    reviewer = UserSerializer(read_only=True)
    class Meta:
        model = Rating
        fields = '__all__'