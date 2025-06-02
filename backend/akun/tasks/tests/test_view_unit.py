from rest_framework.test import APITestCase, APIClient
from rest_framework import status
from django.contrib.auth.models import User
from tasks.models import Task, TaskPost, TaskAnswer, UserProfile
from django.urls import reverse
from datetime import datetime, timedelta
from io import BytesIO
from django.core.files.uploadedfile import SimpleUploadedFile
from django.contrib.auth import get_user_model
from django.utils import timezone

User = get_user_model()

class TaskAPITest(APITestCase):

    def setUp(self):
        self.client = APIClient()

        self.user = User.objects.create_user(username='user1', password='pass')
        self.user2 = User.objects.create_user(username='user2', password='pass')

        self.client.force_authenticate(user=self.user)

        self.profile1 = UserProfile.objects.get(user=self.user)
        self.profile2 = UserProfile.objects.get(user=self.user2)

        self.task = Task.objects.create(
            user=self.user,
            title='Test Task',
            description='Some desc',
            deadline=timezone.now() + timedelta(days=1)
        )

    def test_create_task(self):
        url = reverse('task-list')
        data = {
            'title': 'New Task',
            'description': 'Description',
            'deadline': (datetime.now() + timedelta(days=1)).isoformat()
        }
        response = self.client.post(url, data)
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)

    def test_add_to_todolist(self):
        url = reverse('task-add-to-todolist', args=[self.task.id])
        response = self.client.post(url)
        self.assertEqual(response.status_code, 200)
        self.task.refresh_from_db()
        self.assertTrue(self.task.in_todolist)

    def test_complete_task_without_adding(self):
        url = reverse('task-complete', args=[self.task.id])
        response = self.client.post(url)
        self.assertEqual(response.status_code, 400)

    def test_complete_task(self):
        self.task.in_todolist = True
        self.task.save()
        url = reverse('task-complete', args=[self.task.id])
        response = self.client.post(url)
        self.assertEqual(response.status_code, 200)
        self.task.refresh_from_db()
        self.assertTrue(self.task.is_completed)
        self.assertFalse(self.task.in_todolist)

    def test_task_post_creation_and_query(self):
        url = reverse('taskpost-list')
        new_task = Task.objects.create(
            user=self.user,
            title='Task to Post',
            description='...',
            deadline=timezone.now() + timedelta(days=1)
        )

        data = {
            'task': new_task.id,
            'difficulty': 'mudah',
            'comment': 'Contoh komentar',
            'details': 'Deskripsi postingan tugas',
        }

        response = self.client.post(url, data)
        self.assertEqual(response.status_code, 201)
        self.assertTrue(Task.objects.get(id=new_task.id).is_posted)

        response = self.client.get(url, {'mine': 'true'})
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data), 1)


    def test_task_post_answers_and_approval(self):
        post = TaskPost.objects.create(task=self.task, difficulty='mudah')
        answer = TaskAnswer.objects.create(post=post, user=self.user2, details='Jawaban')

        url = reverse('taskpost-approve-answer', args=[post.id])
        response = self.client.post(url, {'answer_id': answer.id})
        self.assertEqual(response.status_code, 200)

        task2 = Task.objects.create(
            user=self.user,
            title='Task 2',
            description='...',
            deadline=timezone.now() + timedelta(days=1)
        )
        post2 = TaskPost.objects.create(task=task2, difficulty='mudah')
        answer2 = TaskAnswer.objects.create(post=post2, user=self.user, details='My own answer')

        response = self.client.post(
            reverse('taskpost-approve-answer', args=[post2.id]),
            {'answer_id': answer2.id}
        )
        self.assertEqual(response.status_code, 400)


    def test_view_answers_only_by_owner(self):
        post = TaskPost.objects.create(task=self.task, difficulty='mudah')
        TaskAnswer.objects.create(post=post, user=self.user2, details='Test')

        url = reverse('taskpost-answers', args=[post.id])
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)
        self.assertGreaterEqual(len(response.data), 1)

    def test_available_tasks(self):
        url = reverse('taskpost-available-tasks')
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)
        self.assertGreaterEqual(len(response.data), 1)

    def test_answer_creation(self):
        TaskPost.objects.create(task=self.task, difficulty='mudah')
        self.client.force_authenticate(user=self.user2)
        url = reverse('taskanswer-list')
        file = SimpleUploadedFile("file.txt", b"file_content")

        response = self.client.post(url, {
            'post': TaskPost.objects.first().id,
            'details': 'Jawaban saya',
            'file': file
        }, format='multipart')

        self.assertEqual(response.status_code, 201)
        self.assertEqual(TaskAnswer.objects.count(), 1)

    def test_doing_answers(self):
        post = TaskPost.objects.create(task=self.task, difficulty='mudah')
        TaskAnswer.objects.create(post=post, user=self.user, details='My answer')
        url = reverse('taskanswer-doing')
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)

    def test_profile_view(self):
        url = reverse('user-profile')
        response = self.client.get(url)
        self.assertEqual(response.status_code, 200)
        self.assertIn("rank", response.data)
