from django.urls import path, include, re_path
from .views import ProfileDetail
from allauth.account.views import ConfirmEmailView

urlpatterns = [
    path('profile/', ProfileDetail.as_view()),
    path('', include('dj_rest_auth.urls')),
    path('register/', include('dj_rest_auth.registration.urls')),
    re_path(r'^register/account-confirm-email/(?P<key>[-:\w]+)/', ConfirmEmailView.as_view())
]

