from django.contrib.auth.models import Group, Permission
from account.models import User,Customer,ServiceProvider

# Create user groups
customer_group, created = Group.objects.get_or_create(name='Customer')
provider_group, created = Group.objects.get_or_create(name='ServiceProvider')

# Define and assign customer-specific permissions
customer_permissions = [
    Permission.objects.get(codename='can_book_service'),
    # Add other customer-specific permissions
]
customer_group.permissions.set(customer_permissions)

# Define and assign provider-specific permissions
service_provider_permissions = [
    Permission.objects.get(codename='can_provide_service'),
    # Add other provider-specific permissions
]
provider_group.permissions.set(service_provider_permissions)