from rest_framework import serializers

from booking.serializers import BookSerializer
from .models import Payment
from booking.models import Book  # Import the Book model


class CreatePaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = ['id', 'amount', 'transaction_id', 'token', 'booking', 'service_type', 'payment_type']
        read_only_fields = ['id']

    # def create(self, validated_data):
    #     # Extract booking data from validated_data
    #     booking_data = validated_data.pop('booking')

    #     # Create the payment instance
    #     payment_instance = Payment.objects.create(**validated_data)

    #     # Update the associated booking's is_paid field to True
    #     booking_instance = Book.objects.get(id=payment_instance.booking.id)
    #     booking_instance.is_paid = True
    #     booking_instance.save()

    #     return payment_instance
class RetrievePaymentSerializer(serializers.ModelSerializer):
    booking = BookSerializer()

    class Meta:
        model = Payment
        fields = ['id', 'amount', 'transaction_id', 'token', 'booking', 'service_type', 'payment_type']
# serializers.py
from rest_framework import serializers
from .models import Payment

class MonthlyPaymentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment
        fields = '__all__'
