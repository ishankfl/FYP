
import datetime
from django.contrib import admin
from .models import FavoriteProviderr, NullPictures, User, Customer, ServiceProvider
# Register other models
# class ServiceProviderInline(admin.StackedInline):
#     model = ServiceProvider
#     extra = 1
#     fk_name = 'user'
admin.site.register(FavoriteProviderr)
class CustomUserAdmin(admin.ModelAdmin):
    list_display = ('id','username', 'full_name', 'email',
                    'is_active', 'location', 'user_type','password')
    list_filter = ('is_active', 'is_staff')
    fieldsets = (
        ('Personal info', {'fields': ('email','username', 'full_name',
                                      'phonenumber', 'location', 'city','profile', 'user_type','password')}),
        ('Permissions', {'fields': ('is_active', 'is_staff',
         'is_superuser', 'groups', 'user_permissions')}),
        ('Important dates', {'fields': ('last_login', 'date_joined')}),
    )

    search_fields = ('email', 'first_name', 'last_name', 'location')
    ordering = ('id', 'email', 'is_active', 'location')
    # inlines = [ServiceProviderInline]



# class BusinessInline(admin.StackedInline):  # or admin.TabularInline for a more compact view
#     model = Business
#     extra = 1 

class UserAdmin(admin.ModelAdmin):
    list_display = ('username', 'email', 'user_type', 'report_count', 'blacklisted')
    search_fields = ('username', 'email')
    list_filter = ('user_type', 'blacklisted')
    # inlines = [BusinessInline]

@admin.register(Customer)
class CustomerAdmin(admin.ModelAdmin):
    list_display = ('user', 'date', 'verify_status')
    search_fields = ('user__email', 'user__first_name', 'user__last_name')


@admin.register(ServiceProvider)
class ServiceProviderAdmin(admin.ModelAdmin):
    list_display = ('full_name',  'verification_status', 'user_email',
                    'is_available', 'is_booked', 'services_offered', 'location', )
    search_fields = ('user__email', 'user__first_name',
                     'user__last_name', 'experience')
    ordering = ('user__location', )
    readonly_fields = ('display_image',)

    def data_passed_calc(self, date):
        print("Date")
        print(date)
        try:
            user_joined_date = datetime.datetime.strptime(
                str(date), "%Y-%m-%d %H:%M:%S%z")
        except:
            user_joined_date = datetime.datetime.strptime(
                str(date), "%Y-%m-%d %H:%M:%S.%f%z")
        # return (date)

        current_date = datetime.datetime.now(datetime.timezone.utc)
        print(current_date)
        time_difference = current_date - user_joined_date
        print(time_difference)

        # Extract years, months, and days from the difference
        years = time_difference.days // 365
        months = (time_difference.days % 365) // 30
        days = (time_difference.days % 365) % 30
        hours, remainder = divmod(time_difference.seconds, 3600)
        minutes, _ = divmod(remainder, 60)
        timearray = [["Years", years], ["Month", months], [
            "Days", days], ["Hours", hours], ["Minute", minutes]]
        newarr = []
        for i in timearray:
            if (i[1] == 0):
                pass
            else:
                newarr.append(i)
        returntext = ""
        for i in range(0, len(newarr)):

            returntext += f"{newarr[i][1]} {newarr[i][0]} "
        print(returntext)
        return (returntext, "ago")

    def location(self, obj):
        return obj.user.location

    def user_email(self, obj):
        return obj.user.email

    def full_name(self, obj):
        return f"{obj.user.full_name}"

    def join_date(self, obj):
        return obj.user.date_joined

    def join_before(self, obj):
        date = obj.user.date_joined
        return self.data_passed_calc(date=date)



admin.site.register(User, CustomUserAdmin)
admin.site.register(NullPictures)
