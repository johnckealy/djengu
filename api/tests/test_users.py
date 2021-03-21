# from django.contrib.auth.models import User
from rest_framework.test import APITestCase
from rest_framework import status


class UserTests(APITestCase):

    fixtures = ['api/tests/test_fixtures.json']

    def test_create_user(self):
        """Ensure we can create a new account object."""
        url = '/dj-rest-auth/registration/'
        data = {
            'username': 'alice',
            'password1': 'secret12345678',
            'password2': 'secret12345678',
            'first_name': 'Alice',
            'last_name': 'InChains',
            'email': 'alice@email.com',
        }
        response = self.client.post(url, data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertEqual(response.data['user']['username'], 'alice')


    def test_login(self):
        """Ensure we can Login."""
        response = self.client.login(username='jane', password='secret')
        self.assertTrue(response)
