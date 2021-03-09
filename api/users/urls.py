from django.urls import path, include
from .views import  UserProfile



urlpatterns = [
    path('dj-rest-auth/', include('dj_rest_auth.urls')),
    path('dj-rest-auth/registration/', include('dj_rest_auth.registration.urls')),
    path('profile/', UserProfile.as_view(), name='user_profile'),
]

