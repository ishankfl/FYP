from django.contrib import admin
from .models import Bid

# Define the admin class for Bid
class BidAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'service', 'text_content', 'timestamp', 'is_deleted')
    list_filter = ('service', 'timestamp', 'is_deleted')
    search_fields = ('text_content', 'location')

# Register the Bid model with its admin class
admin.site.register(Bid, BidAdmin)
