import unittest
from unittest.mock import patch, MagicMock
from rest_framework.test import APIRequestFactory
from rest_framework.request import Request
from rest_framework.response import Response
from django.contrib.auth import get_user_model
from rest_framework.test import force_authenticate
from tasks.views import TaskViewSet, TaskPostViewSet, TaskAnswerViewSet

User = get_user_model()


class TaskViewSetTestCase(unittest.TestCase):
    def setUp(self):
        self.factory = APIRequestFactory()
        self.user = MagicMock()
        self.user.is_authenticated = True

        self.task_mock = MagicMock()
        self.task_mock.in_todolist = False
        self.task_mock.is_completed = False

    @patch('tasks.views.TaskViewSet.get_object')
    def test_add_to_todolist(self, mock_get_object):
        request = self.factory.post('/tasks/1/add_to_todolist/')
        force_authenticate(request, user=self.user)
        mock_get_object.return_value = self.task_mock

        view = TaskViewSet.as_view({'post': 'add_to_todolist'})
        response = view(request, pk=1)

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['status'], 'Task ditambahkan ke ToDoList')
        self.assertTrue(self.task_mock.in_todolist)
        self.task_mock.save.assert_called_once()

    @patch('tasks.views.TaskViewSet.get_object')
    def test_complete_success(self, mock_get_object):
        request = self.factory.post('/tasks/1/complete/')
        force_authenticate(request, user=self.user)
        self.task_mock.in_todolist = True
        mock_get_object.return_value = self.task_mock

        view = TaskViewSet.as_view({'post': 'complete'})
        response = view(request, pk=1)

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['status'], 'Task diselesaikan')
        self.assertTrue(self.task_mock.is_completed)
        self.assertFalse(self.task_mock.in_todolist)
        self.task_mock.save.assert_called_once()


class TaskPostViewSetTestCase(unittest.TestCase):
    def setUp(self):
        self.factory = APIRequestFactory()
        self.user = MagicMock()
        self.user.is_authenticated = True
        self.task_mock = MagicMock()
        self.post_mock = MagicMock()
        self.answer_mock = MagicMock()
        self.profile_mock = MagicMock()

    @patch('tasks.views.TaskPostViewSet.get_object')
    @patch('tasks.views.TaskAnswer.objects.get')
    @patch('tasks.views.UserProfile.objects.get_or_create')
    def test_approve_answer_success(self, mock_get_or_create, mock_answer_get, mock_get_object):
        request = self.factory.post('/task-posts/1/approve_answer/', {'answer_id': 123}, format='json')
        force_authenticate(request, user=self.user)
        self.post_mock.task.user = self.user
        self.answer_mock.user = MagicMock()
        self.answer_mock.user != self.user
        mock_get_object.return_value = self.post_mock
        mock_answer_get.return_value = self.answer_mock
        mock_get_or_create.return_value = (self.profile_mock, True)

        view = TaskPostViewSet.as_view({'post': 'approve_answer'})
        response = view(request, pk=1)

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['status'], 'Jawaban disetujui & poin diberikan')
        self.post_mock.save.assert_called_once()
        self.profile_mock.save.assert_called_once()
        self.profile_mock.update_rank.assert_called_once()
