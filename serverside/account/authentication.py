from account.models import User
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth import get_user_model


class EmailOrPhoneBackend(ModelBackend):

    def authenticate(self, request, email=None, password=None, **kwargs):
        UserModel = get_user_model()
        print(UserModel)
        print(email, password)
        try:
            # Try to find user by email
            user = UserModel.objects.get(email=email)
            print(email)
            print("HHHHH")
        except:
            try:
                # If not found, try phone number
                user = UserModel.objects.get(email=email)

            except:
                user = UserModel.objects.filter(phonenumber=email).first()
                # except:

        if user and user.check_password(password):
            return user
        return None

    def get_user(self, user_id):
        UserModel = get_user_model()
        try:
            return UserModel.objects.get(pk=user_id)
        except UserModel.DoesNotExist:
            return None
