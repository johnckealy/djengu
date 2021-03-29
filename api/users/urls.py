from django.urls import path, include, re_path
from .views import ProfileDetail, EmailVerifiedView, ResendEmailConfirmation
from dj_rest_auth.registration.views import VerifyEmailView, ConfirmEmailView
from dj_rest_auth.views import PasswordResetConfirmView
from django.views.generic import TemplateView


urlpatterns = [
    path('profile/', ProfileDetail.as_view()),
    path('', include('dj_rest_auth.urls')),
    path('register/account-confirm-email/<str:key>/', ConfirmEmailView.as_view()),
    path('register/', include('dj_rest_auth.registration.urls')),
    path('account-confirm-email/', VerifyEmailView.as_view(), name='account_email_verification_sent'),
    path('register/email-verified/', EmailVerifiedView.as_view(), name='email_verified'),
    path('register/resend-confirmation-email/', ResendEmailConfirmation.as_view(), name='resend_confirmation_email'),

    path('password/reset/confirm/<uidb64>/<token>/', PasswordResetConfirmView.as_view(), name='password_reset_confirm'),

]

