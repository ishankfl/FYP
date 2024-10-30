from django.contrib import admin
from .models import Notificationss, Mobile, Announcement, Announce

class NotificationssAdmin(admin.ModelAdmin):
    list_display = ('id','title', 'sender', 'rece', 'success', 'type', 'notification_type', 'is_positive', 'time')
    list_filter = ('success', 'notification_type', 'is_positive')
    search_fields = ('title', 'sender__username', 'rece__username')
    date_hierarchy = 'time'

class MobileAdmin(admin.ModelAdmin):
    list_display = ('phone_key', 'user', 'device_name', 'is_loggedin')
    list_filter = ('is_loggedin',)
    search_fields = ('user__username', 'device_name')

class AnnouncementAdmin(admin.ModelAdmin):
    list_display = ('title', 'body')

class AnnounceAdmin(admin.ModelAdmin):
    list_display = ('user', 'title', 'body')

admin.site.register(Notificationss, NotificationssAdmin)
admin.site.register(Mobile, MobileAdmin)
admin.site.register(Announcement, AnnouncementAdmin)
admin.site.register(Announce, AnnounceAdmin)
