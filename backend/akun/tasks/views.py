from rest_framework import viewsets, permissions
from accounts import serializers
from .models import Task, TaskPost, TaskAnswer, Task, UserProfile
from .serializers import TaskSerializer, TaskPostSerializer, TaskAnswerSerializer
from rest_framework.decorators import action
from rest_framework.response import Response
from rest_framework import status
from datetime import datetime, timedelta
from django.db.models import Count
from django.db.models.functions import TruncWeek, TruncMonth
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from tasks.models import UserProfile
import sentry_sdk

class TaskViewSet(viewsets.ModelViewSet):
    serializer_class = TaskSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Task.objects.filter(user=self.request.user).order_by('-created_at')

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    @action(detail=True, methods=['post'])
    def add_to_todolist(self, request, pk=None):
        task = self.get_object()
        task.in_todolist = True
        task.save()
        return Response({'status': 'Task ditambahkan ke ToDoList'})

    @action(detail=True, methods=['post'])
    def remove_from_todolist(self, request, pk=None):
        task = self.get_object()
        task.in_todolist = False
        task.save()
        return Response({'status': 'Task dikeluarkan dari ToDoList'})

    @action(detail=True, methods=['post'])
    def complete(self, request, pk=None):
        task = self.get_object()
        if not task.in_todolist:
            return Response({'error': 'Task harus ada di ToDoList sebelum diselesaikan'}, status=400)
        task.is_completed = True
        task.in_todolist = False
        task.save()
        return Response({'status': 'Task diselesaikan'})


# class TaskViewSet(viewsets.ModelViewSet):
#     serializer_class = TaskSerializer
#     permission_classes = [permissions.IsAuthenticated]

#     def get_queryset(self):
#         return Task.objects.filter(user=self.request.user).order_by('-created_at')

#     def perform_create(self, serializer):
#         serializer.save(user=self.request.user)

class TaskPostViewSet(viewsets.ModelViewSet):
    queryset = TaskPost.objects.all()
    serializer_class = TaskPostSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        task = serializer.validated_data['task']
        if task.user != self.request.user:
            raise serializers.ValidationError("Kamu hanya bisa post tugas milikmu sendiri.")
        task.is_posted = True
        task.save()
        serializer.save()

    def get_queryset(self):
        user = self.request.user
        mine = self.request.query_params.get('mine')
        others = self.request.query_params.get('others')

        qs = TaskPost.objects.all()

        if mine == 'true':
            return qs.filter(task__user=user)
        elif others == 'true':
            return qs.exclude(task__user=user)
        return qs

    def get_object(self):
        obj = super().get_object()
        return obj  # validasi spesifik dilakukan di tiap action

    @action(detail=True, methods=['post'], permission_classes=[permissions.IsAuthenticated])
    def approve_answer(self, request, pk=None):
        post = self.get_object()

        if post.task.user != request.user:
            return Response({'error': 'Kamu bukan pemilik tugas ini'}, status=403)

        answer_id = request.data.get('answer_id')
        try:
            answer = TaskAnswer.objects.get(pk=answer_id, post=post)
        except TaskAnswer.DoesNotExist:
            return Response({'error': 'Jawaban tidak ditemukan'}, status=404)

        if answer.user == request.user:
            return Response({'error': 'Kamu tidak bisa approve jawabanmu sendiri'}, status=400)

        post.approved_answer = answer
        post.is_closed = True
        post.save()

        try:
            from decimal import Decimal
            profile, created = UserProfile.objects.get_or_create(user=answer.user)
            percent = Decimal('10') if post.difficulty == 'susah' else Decimal('5')
            profile.points += percent
            profile.save()
            profile.update_rank()
        except Exception as e:
            sentry_sdk.capture_exception(e)
            import traceback
            return Response({
                'error': 'Jawaban disetujui tapi gagal memberi poin',
                'type': str(type(e)),
                'message': str(e),
                'trace': traceback.format_exc()
            }, status=500)

        return Response({'status': 'Jawaban disetujui & poin diberikan'})


    @action(detail=True, methods=['get'], permission_classes=[permissions.IsAuthenticated])
    def answers(self, request, pk=None):
        try:
            post = self.get_object()
            if post.task.user != request.user:
                return Response({'error': 'Hanya pemilik tugas yang bisa melihat semua jawaban'}, status=403)

            answers = TaskAnswer.objects.filter(post=post).select_related('user')
            serializer = TaskAnswerSerializer(answers, many=True)
            return Response(serializer.data)

        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Gagal memuat jawaban'}, status=500)

    @action(detail=False, methods=['get'], permission_classes=[permissions.IsAuthenticated])
    def available_tasks(self, request):
        try:
            tasks = Task.objects.filter(user=request.user, is_posted=False, is_completed=False)
            serializer = TaskSerializer(tasks, many=True)
            return Response(serializer.data)
        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({"error": "Gagal memuat daftar task yang bisa dipost"}, status=500)


class TaskAnswerViewSet(viewsets.ModelViewSet):
    queryset = TaskAnswer.objects.all()
    serializer_class = TaskAnswerSerializer
    permission_classes = [permissions.IsAuthenticated]

    def perform_create(self, serializer):
        post = serializer.validated_data['post']
        if post.task.user == self.request.user:
            raise serializers.ValidationError("Kamu tidak bisa menjawab tugasmu sendiri.")
        serializer.save(user=self.request.user)
    
    @action(detail=False, methods=['get'])
    def doing(self, request):
        try:
            queryset = TaskAnswer.objects.filter(
                user=request.user,
                post__is_closed=False
            ).select_related('post', 'post__task')

            serializer = self.get_serializer(queryset, many=True)
            return Response(serializer.data)
        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({"error": "Gagal memuat tugas yang sedang dikerjakan"}, status=500)

class UserProfileView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            profile = UserProfile.objects.get(user=request.user)
            return Response({
                "username": request.user.username,
                "rank": profile.rank,
                "points": profile.points
            })
        except UserProfile.DoesNotExist:
            return Response({"error": "Profile tidak ditemukan"}, status=404)
