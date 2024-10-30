from rest_framework import serializers

from account.serializers import UserSerializer
from notification.models import Announcement, Notificationss

class NotificationSerializer(serializers.ModelSerializer):
    rece=UserSerializer()
    sender=UserSerializer()
    class Meta:
        model = Notificationss
        fields = '__all__'

class AnnouncementSerializer(serializers.ModelSerializer):
    user=UserSerializer()
    class Meta:
        model= Announcement
        fields='__all__'
        read_only_fields=['user']
