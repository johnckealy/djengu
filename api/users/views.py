from rest_framework import generics
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from .serializers import ProfileSerializer
from .models import Profile


class ProfileDetail(generics.GenericAPIView):

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



class VerifyEmailView(generics.GenericAPIView):

    def get(self, request, *args, **kwargs):
        return Response({ 'message': 'Email verified?'})

