from rest_framework import serializers
from account.serializers import UserSerializer

from bid.models import Bid, Comment
from services.serializers import ServicesSerializers

class BidSerializers(serializers.ModelSerializer):
      user=UserSerializer()
      service=ServicesSerializers()
      class Meta:
            model= Bid
            fields='__all__'


class CommentSerializers(serializers.ModelSerializer):
      user=UserSerializer()
      bid=BidSerializers()
      class Meta:
            model= Comment
            fields='__all__'

#                 by = CustomerSerializer()
#     to = ServiceProviderSerializer()
#     service = ServicesSerializers()  # Make sure to replace 'ServicesSerializers' with the actual serializer for your 'Services' model
