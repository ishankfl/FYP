from django.contrib import admin
from .models import Payment

class PaymentAdmin(admin.ModelAdmin):
    list_display = ('amount', 'transaction_id', 'token', 'booking', 'service_type', 'payment_type', 'payment_date')
    list_filter = ('service_type', 'payment_type', 'payment_date')
    search_fields = ('transaction_id', 'token', 'booking__id')
    date_hierarchy = 'payment_date'

admin.site.register(Payment, PaymentAdmin)
