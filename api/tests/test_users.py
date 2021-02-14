# from django.contrib.auth.models import User
from rest_framework.test import APITestCase
from rest_framework import status


class UserTests(APITestCase):

    fixtures = ['api/tests/test_fixtures.json']

    def test_create_user(self):
        """Ensure we can create a new account object."""
        url = '/api/register/'
        data = {
            'username': 'alice',
            'password': 'secret',
            'first_name': 'Alice',
            'last_name': 'InChains',
            'email': 'alice@email.com',
        }
        response = self.client.post(url, data)
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertEqual(response.data['user']['username'], 'alice')


    def test_login(self):
        """Ensure we can Login."""
        response = self.client.login(username='jane', password='secret')
        self.assertTrue(response)
