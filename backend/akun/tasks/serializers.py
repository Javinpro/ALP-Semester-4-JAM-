from rest_framework import serializers
from .models import Task, TaskAnswer, TaskPost, UserProfile
from datetime import datetime

class TaskSerializer(serializers.ModelSerializer):
    class Meta:
        model = Task
        fields = '__all__'
        read_only_fields = ['user', 'created_at']

    def validate_deadline(self, value):
        if value.date() < datetime.now().date():
            raise serializers.ValidationError("Deadline tidak boleh di tanggal yang sudah lewat.")
        return value

class TaskPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = TaskPost
        fields = '__all__'
        read_only_fields = ['is_closed', 'approved_answer']

    def validate_task(self, value):
        request = self.context['request']
        if value.user != request.user:
            raise serializers.ValidationError("Kamu hanya bisa mem-post task milikmu sendiri.")
        if value.is_posted:
            raise serializers.ValidationError("Tugas ini sudah pernah dipost.")
        if value.is_completed:
            raise serializers.ValidationError("Tugas yang sudah selesai tidak bisa dipost.")
        return value


class TaskAnswerSerializer(serializers.ModelSerializer):
    username = serializers.CharField(source='user.username', read_only=True)

    class Meta:
        model = TaskAnswer
        fields = ['id', 'post', 'username', 'details', 'comment', 'file', 'created_at']
        read_only_fields = ['user', 'created_at']


class UserProfileSerializer(serializers.ModelSerializer):
    class Meta:
        model = UserProfile
        fields = ['points', 'rank']


