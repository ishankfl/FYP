from django.contrib import admin
from .models import ChatModel

class ChatModelAdmin(admin.ModelAdmin):
    list_display = ('chat_groupName', 'sender', 'message', 'receiver', 'timestamp')
    list_filter = ('chat_groupName', 'sender', 'receiver', 'timestamp')
    search_fields = ('chat_groupName', 'sender', 'receiver', 'message')
    date_hierarchy = 'timestamp'

admin.site.register(ChatModel, ChatModelAdmin)
