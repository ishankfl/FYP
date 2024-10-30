from django.contrib import admin
from django.urls import reverse
from django.utils.html import format_html
from urllib.parse import urlencode
from .models import Book

class BookAdmin(admin.ModelAdmin):
    list_display = ('by', 'service', 'to', 'location', 'status', 'booking_start_date_time', 'booking_end_date_time', 'is_paid', 'view_map')
    list_filter = ('status', 'is_paid')
    search_fields = ('by__username', 'to__username', 'location')
    date_hierarchy = 'booking_start_date_time'

    def view_map(self, obj):
        if obj.latitude and obj.longitude:
            google_maps_url = f"https://www.google.com/maps/search/?api=1&query={obj.latitude},{obj.longitude}"
            return format_html('<a href="{}" target="_blank">View Map</a>', google_maps_url)
        else:
            return '-'

    view_map.short_description = 'Map'

admin.site.register(Book, BookAdmin)
