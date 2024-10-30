
# Create your views here.
import datetime
from django.shortcuts import get_object_or_404
from rest_framework.views import APIView

from rest_framework.views import Response
from rest_framework.views import status
from account.models import Customer, ServiceProvider, User

from booking.models import Book

from .models import Payment
from .serializers import CreatePaymentSerializer, RetrievePaymentSerializer
class PaymentView(APIView):
    def get(self, request, *args, **kwargs):
        payments = Payment.objects.all()
        serializer = RetrievePaymentSerializer(payments, many=True)
        return Response(serializer.data)

    
    def post(self, request, *args, **kwargs):
        # Validate if required fields are present in the request data
        required_fields = ['amount', 'transaction_id', 'booking', 'payment_type']
        for field in required_fields:
            if field not in request.data:
                return Response({'error': f'{field} is required'}, status=status.HTTP_400_BAD_REQUEST)

        book_id = request.data.get('booking', 11)
        try:
            book_instance = Book.objects.get(id=book_id)
        except Book.DoesNotExist:
            return Response({'error': 'Invalid booking ID'}, status=status.HTTP_400_BAD_REQUEST)

        # Prepare data for Payment creation
        payment_data = {
            'amount': request.data['amount'],
            'transaction_id': request.data['transaction_id'],
            'booking': book_id,  # Provide the booking data as a dictionary
            'payment_type': request.data['payment_type'],
            'token': request.data['token'],
            'service_type': request.data['service_type'],
        }

        payment_serializer = CreatePaymentSerializer(data=payment_data)
        if payment_serializer.is_valid():
            payment_serializer.save()
            print(payment_serializer.data['id'])
            book_instance.is_paid=True
            book_instance.save()
            serializers=RetrievePaymentSerializer(instance=Payment.objects.get(id=payment_serializer.data['id']))
         

            return Response({'success': 'Payment created successfully','data':serializers.data}, status=status.HTTP_201_CREATED)
        else:
            return Response({'error': payment_serializer.errors}, status=status.HTTP_400_BAD_REQUEST)


from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import Payment

class PaymentHistoryView(APIView):
    def get(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            # Filter payments based on the user's ID
            user_instance = get_object_or_404(User, email=request.user)
        
            customer_instance = get_object_or_404(Customer, user=user_instance)
        
            user_payments = Payment.objects.filter(booking__by=customer_instance)
            # Serialize the payment data
            payment_serializer = RetrievePaymentSerializer(user_payments, many=True)

            return Response(payment_serializer.data, status=status.HTTP_200_OK)

        return Response({'error': 'User not authenticated'}, status=status.HTTP_401_UNAUTHORIZED)
from django.db.models import Sum

class MontlyIncomeView(APIView):
        def post(self, request, *args, **kwargs):
            user=request.user
            provider=ServiceProvider.objects.get(user=user)
            print(user)
            # Retrieve payments for the given provider for the current year
            payments = Payment.objects.filter(booking__to=provider.id, payment_date__year=datetime.datetime.now().year)
            # Calculate monthly income
            monthly_income = payments.values('payment_date__month').annotate(total_income=Sum('amount'))
            print(monthly_income)
            return Response(monthly_income)