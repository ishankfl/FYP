
import django
import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "bookme.settings")
django.setup()
import json
from channels.generic.websocket import AsyncWebsocketConsumer
from chat.models import ChatModel
from channels.db import database_sync_to_async
from channels.exceptions import StopConsumer

class ChatConsumer(AsyncWebsocketConsumer):
    async def connect(self): 
        self.username_from = int(self.scope['url_route']['kwargs']['username_from'])
        self.username_to = int(self.scope['url_route']['kwargs']['username_to'])
        self.room_channel_name = f"chat_{min(self.username_from, self.username_to)}_{max(self.username_from, self.username_to)}"
        print(self.room_channel_name)
        await self.channel_layer.group_add(
            self.room_channel_name,
            self.channel_name
        )
        await self.accept()
    async def disconnect(self , close_code):
        await self.channel_layer.group_discard(
            self.room_channel_name , 
            self.channel_layer 
        )
        StopConsumer()
    @database_sync_to_async
    def save_message_to_database(self, sender, receiver, text):
        # Save the message to the database
        message = ChatModel.objects.create(
            chat_groupName=str(self.room_channel_name),
            sender=sender,
            receiver=receiver,
            message=text,
        )
        return message
    async def receive(self, text_data):
        print(text_data)
        text_data_json = json.loads(text_data)
        message = text_data_json["message"]
        sender = text_data_json["from"]
        receiver = text_data_json["to"]
        self.message_=message
        self.sender=sender
        self.received_=receiver
        await self.save_message_to_database(sender, receiver, message)
        await self.channel_layer.group_send(
            self.room_channel_name,{
                "type" : 'message' ,
                "message" : message , 
                "from" : sender , 
                "to" : receiver ,
            })
    async def message(self, event):
        await self.send(text_data=json.dumps({
            'message': event['message'],
            'username_from': event['from'],
            'username_to': event['to'],
            'timestamp': 'event',
        }))
    
class TypingMessageConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        self.username_from = int(self.scope['url_route']['kwargs']['username_from'])
        self.username_to = int(self.scope['url_route']['kwargs']['username_to'])
        self.room_channel_name = f"individual_{min(self.username_from, self.username_to)}_{max(self.username_from, self.username_to)}"
        print(self.room_channel_name)
        await self.channel_layer.group_add(
            self.room_channel_name,
            self.channel_name
        )
        await self.accept()

    async def receive(self, text_data):
        print("received")
        print(text_data)
        username_from=0
        username_to=0
        if(text_data=="userbacked"):
            username_from=0
            username_to=0
        else:
            username_from=self.username_from
            username_to=self.username_to
        print(username_from)
        print(username_to)
        await self.channel_layer.group_send(
            self.room_channel_name,{
                "type" : 'message' ,
                "from":username_from,
                "to":username_to               
            })
    async def message(self, event):
        await self.send(text_data=json.dumps({
            'to': event['to'],
            'from': event['from'],
        }))
    
    async def disconnect(self, close_code):
        await self.send(text_data=json.dumps({
            'message': 'close',
            # 'username_from': event['from'],
        }))
        await self.channel_layer.group_discard(
        self.room_channel_name,
        self.channel_name
    )
        StopConsumer()