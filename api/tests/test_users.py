# from django.contrib.auth.models import User
from rest_framework.test import APITestCase
from rest_framework import status
import json

class UserTests(APITestCase):

    fixtures = ['api/tests/test_fixtures.json']

    def test_register(self):
        """Ensure we can create a new account object."""
        url = '/register/'
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

    def test_token_refresh(self):
        url = '/token/refresh/'
        response = self.client.post('/login/', {'username': 'jane', 'password': 'secret'})
        content = json.loads(response.content)
        refresh_token = {'refresh': content['refresh_token']}
        response = self.client.post(url, refresh_token, format='json')
        self.assertEqual(response.status_code, status.HTTP_200_OK)
        self.assertIn('access', response.data.keys())

    def test_logout(self):
        self.client.post('/login/', {'username': 'jane', 'password': 'secret'})
        user = self.client.get('/user/').data
        self.assertEqual(user['username'], 'jane')
        response = self.client.post('/logout/', {})
        self.assertEqual(response.data['detail'], 'Successfully logged out.')