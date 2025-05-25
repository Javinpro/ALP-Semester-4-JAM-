from django.db import models
from django.apps import AppConfig
from django.db import models
from django.contrib.auth import get_user_model

User = get_user_model()

class Task(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='tasks')
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    deadline = models.DateTimeField()
    is_completed = models.BooleanField(default=False)
    in_todolist = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)
    is_posted = models.BooleanField(default=False)

class TaskPost(models.Model):
    task = models.OneToOneField(Task, on_delete=models.CASCADE, related_name='post')
    difficulty = models.CharField(max_length=10, choices=[('mudah', 'Mudah'), ('susah', 'Susah')])
    details = models.TextField()
    comment = models.TextField(blank=True)
    is_closed = models.BooleanField(default=False)
    approved_answer = models.ForeignKey(
        "TaskAnswer", null=True, blank=True, on_delete=models.SET_NULL, related_name='approved_for_post'
    )


class TaskAnswer(models.Model):
    post = models.ForeignKey(TaskPost, on_delete=models.CASCADE, related_name='answers')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    details = models.TextField()
    file = models.FileField(upload_to='answers/', null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    comment = models.TextField(blank=True)

class UserProfile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    points = models.DecimalField(default=0, max_digits=6, decimal_places=2)
    rank = models.CharField(max_length=10, choices=[('beginner', 'Beginner'), ('master', 'Master'), ('pro', 'Pro')], default='beginner')

    def update_rank(self):
        if self.points >= 100:
            if self.rank == 'beginner':
                self.rank = 'master'
            elif self.rank == 'master':
                self.rank = 'pro'
            self.points = self.points % 100
            self.save()

