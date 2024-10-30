from django.urls import path

from . import consumers

websocket_urlpatterns = [
    path('ws/personalChat/<username_from>/<username_to>/', consumers.ChatConsumer.as_asgi()),
    path('ws/typingMessage/<username_from>/<username_to>/', consumers.TypingMessageConsumer.as_asgi()),
]
