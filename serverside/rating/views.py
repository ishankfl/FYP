from django.shortcuts import render
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import generics, status
from django.http import JsonResponse
from django.db.models import Avg

from account.models import ServiceProvider, User
from booking.models import Book
from rating.models import Rating
from rating.serializers import RatingSerializer


# Create your views here.
class AddReview(APIView):
    def post(self, request, *args, **kwargs):
        # Retrieve the post object
        book_id=request.data['book_id']
        try:
            book = Book.objects.get(id=book_id)
            client=book.by.user
            provider= book.to.user
            print(request.data)
            ratingobj=Rating.objects.create(
                provider=provider,
                reviewer=client,
                ratings=request.data['rate'],
                review=request.data['description'],
            )
            ratingobj.save()
            serializer =RatingSerializer(ratingobj)
            return Response({'success':1,'message':"Successfully created",'data':serializer.data}, status=status.HTTP_201_CREATED)
        except User.DoesNotExist:
            return Response({'error':1, "message": "Provider User does not exist"}, status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print(e)
            return Response({'error':1, "message": "Something went wrong"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        # Create a commen