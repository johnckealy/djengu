from django.urls import path, include
from .views import  UserProfile
from allauth.account.views import confirm_email




urlpatterns = [
    path('', include('dj_rest_auth.urls')),
    path('dj-rest-auth/registration/', include('dj_rest_auth.registration.urls')),
    path('profile/', UserProfile.as_view(), name='user_profile'),
]

