from django.contrib import admin
from django.urls import include, path
from django.conf import settings
from django.conf.urls.static import static

# schema_view = get_swagger_view(title='Pastebin API')

urlpatterns = [
    # path('', schema_view),
    path('admin/', admin.site.urls),
    path('account/', include('account.urls'), name="account"),
    path('booking/', include('booking.urls'), name="booking"),
    path('services/', include('services.urls'), name="booking"),
    path('bid/', include('bid.urls'), name="bid"),
    path('chat/', include('chat.urls'), name="chat"),
    path('payment/', include('payment.urls'), name="payment"),
    path('notify/', include('notification.urls'), name="payment"),
    path('rating/', include('rating.urls'), name="payment"),
    path('emergency/', include('emergencybooking.urls'), name="emergencybooking"),
    # path('admin/', include('admin.urls'), name="payment"),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
