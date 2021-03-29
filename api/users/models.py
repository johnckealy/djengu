from django.db import models
from django.contrib.auth.models import User


class Profile(models.Model):
    """ A one to one model for extra user fields"""
    user = models.OneToOneField(User, on_delete=models.CASCADE, null=True)
