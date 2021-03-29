import os
from django.views.generic import TemplateView
from rest_framework import generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated, AllowAny
from allauth.account.utils import send_email_confirmation
from .serializers import ProfileSerializer
from .models import Profile


class ProfileDetail(generics.GenericAPIView):
    """An extension of the User model for custom logic about the user."""
    permission_classes = [ IsAuthenticated ]
    serializer_class = ProfileSerializer

    def get(self, request, *args, **kwargs):
        """Get the User profile information, if it exists."""
        user = request.user
        try:
            profile_serializer = ProfileSerializer(user.profile)
            return Response(profile_serializer.data)
        except:
            return Response({ 'message': 'Nothing here.'})


    def post(self, request, format=None):
        """Get or create a user Profile and modify it."""
        try:
            profile = Profile.objects.get(user=request.user)
        except:
            profile = Profile.objects.create(user=request.user)

        # Add your logic for modifying the user Profile here

        return Response(ProfileSerializer(profile).data)



class EmailVerifiedView(TemplateView):
    """Returns the HTML template for the confirm registration email"""
    template_name = "confirmed_email.html"

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['home_url'] = os.environ.get('ORIGIN_URL')
        return context


class ResendEmailConfirmation(generics.GenericAPIView):
    """Resends the registration confirmation email."""
    permission_classes = (AllowAny,)

    def get(self, request):
        send_email_confirmation(request._request, request.user)
        return Response({'message': 'Email confirmation re-sent'})


