from rest_framework import  serializers
from django.contrib.auth.models import User
from dj_rest_auth.registration.serializers import RegisterSerializer
from .models import Profile
from dj_rest_auth.serializers import PasswordResetSerializer


class CustomRegisterSerializer(RegisterSerializer):
    """Add a first name field to the default user registration."""
    first_name = serializers.CharField(required=True, write_only=True)

    def get_cleaned_data(self):
        return {
            'first_name': self.validated_data.get('first_name', ''),
            'username': self.validated_data.get('username', ''),
            'password1': self.validated_data.get('password1', ''),
            'email': self.validated_data.get('email', ''),
        }



class CustomPasswordResetSerializer(PasswordResetSerializer):
    def get_email_options(self):
        return {
            'extra_email_context': {
                'pass_reset_obj':{ 'this_thing': 'This is the this thing'}
            },
            'Hlloe': 'Yea'
        }



class ProfileSerializer(serializers.ModelSerializer):
    """Everything from the user model including the custom user fields."""
    class Meta:
        model = Profile
        fields = "__all__"