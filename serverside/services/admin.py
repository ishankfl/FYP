from django.contrib import admin
from .models import Services, ReviewandRate

class ReviewandRateInline(admin.StackedInline):
    model = ReviewandRate
    can_delete = False
    verbose_name_plural = 'Review and Rate'

class ServicesAdmin(admin.ModelAdmin):
    list_display = ('service_name', 'slug', 'image', 'service_description', 'hourly_rate', 'is_available', 'total_providers')
    list_filter = ('is_available',)
    search_fields = ('service_name', 'service_description')
    prepopulated_fields = {'slug': ('service_name',)}
    inlines = [ReviewandRateInline]

admin.site.register(Services, ServicesAdmin)
