from django.contrib.auth.models import User
from utils import L, LOG
import os


def run():
    """Script to create two test users, one for John and one for Admin."""
    LOG.info(f"\nCreating test users...")
    if not User.objects.filter(username='guest').exists():
        user=User.objects.create_user(username='guest', email='guest@email.com', first_name="Guest", password='secret')
        user.is_superuser=False
        user.is_staff=False
        user.save()
        LOG.info(f"\n{L.SUCCESS} Normal User 'guest' created.{L.ENDC}\n")

    if not User.objects.filter(username='admin').exists():
        user = User.objects.create_user(username='admin', email='admin@email.com',
                                        password=os.environ.get("DJANGO_ADMIN_PASSWORD"))
        user.is_superuser=True
        user.is_staff=True
        user.save()
        LOG.info(f"\n{L.SUCCESS} Superuser 'admin' created.{L.ENDC}\n")
    LOG.info(f"Done.")
