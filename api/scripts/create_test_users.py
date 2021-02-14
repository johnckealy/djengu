from django.contrib.auth.models import User
from utils import L, LOG


def run():
    """Script to create two test users, one for John and one for Admin."""
    LOG.info(f"\nCreating test users...")
    if not User.objects.filter(username='john@email.com').exists():
        user=User.objects.create_user(username='john@email.com', email='john@email.com', first_name="John", password='asdf')
        user.is_superuser=False
        user.is_staff=False
        user.save()
        LOG.info(f"\n{L.SUCCESS} Normal User 'john@email.com' created.{L.ENDC}\n")

    if not User.objects.filter(username='admin_user').exists():
        user=User.objects.create_user(username='admin_user', email='admin@email.com', password='asdf')
        user.is_superuser=True
        user.is_staff=True
        user.save()
        LOG.info(f"\n{L.SUCCESS} Superuser 'admin' created.{L.ENDC}\n")
    LOG.info(f"Done.")
