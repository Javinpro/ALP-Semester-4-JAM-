# akun/views.py

from django.contrib.auth import authenticate
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework import status, permissions
from django.utils.timezone import now
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import TokenAuthentication
from .serializers import RegisterSerializer, LoginSerializer, ProfileUpdateSerializer, TugasSerializer
from .models import Tugas
from rest_framework.generics import ListCreateAPIView, RetrieveUpdateDestroyAPIView
from django.contrib.auth.models import User
import sentry_sdk
from datetime import datetime, timedelta

class RegisterView(APIView):
    def post(self, request):
        try:
            if User.objects.filter(username=request.data.get('username')).exists():
                return Response({'error': 'Username already exists'}, status=status.HTTP_400_BAD_REQUEST)

            serializer = RegisterSerializer(data=request.data)
            if serializer.is_valid():
                user = serializer.save()
                token, _ = Token.objects.get_or_create(user=user)
                return Response({'token': token.key}, status=status.HTTP_201_CREATED)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Internal server error'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class LoginView(APIView):
    def post(self, request):
        try:
            serializer = LoginSerializer(data=request.data)
            if serializer.is_valid():
                username = serializer.validated_data['username']
                password = serializer.validated_data['password']

                # Cek apakah username ada
                try:
                    user = User.objects.get(username=username)
                except User.DoesNotExist:
                    return Response({'error': 'Username not found'}, status=status.HTTP_404_NOT_FOUND)

                # Cek password
                if not user.check_password(password):
                    return Response({'error': 'Incorrect password'}, status=status.HTTP_401_UNAUTHORIZED)

                # Login berhasil
                token, _ = Token.objects.get_or_create(user=user)
                sentry_sdk.set_user({"id": user.id, "username": user.username})
                return Response({'token': token.key}, status=status.HTTP_200_OK)

            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Internal server error'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class LogoutView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def post(self, request):
        request.user.auth_token.delete()  # Hapus token
        return Response({"message": "Logout berhasil"}, status=status.HTTP_200_OK)

class ProfileUpdateView(APIView):
    authentication_classes = [TokenAuthentication]
    permission_classes = [IsAuthenticated]

    def put(self, request):
        try:
            user = request.user
            serializer = ProfileUpdateSerializer(user, data=request.data, partial=True, context={'request': request})

            if serializer.is_valid():
                serializer.save()
                return Response({'message': 'Profile updated successfully'})
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        except Exception as e:
            sentry_sdk.set_user({"id": request.user.id, "username": request.user.username})
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Internal server error'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class TugasListCreateView(ListCreateAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        try:
            if request.user.is_anonymous:
                return Response({'error': 'Authentication required'}, status=401)

            tugas = Tugas.objects.filter(user=request.user).order_by('-created_at')
            serializer = TugasSerializer(tugas, many=True)
            return Response(serializer.data)

        except Exception as e:
            sentry_sdk.set_user({"username": str(request.user)})
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Failed to fetch tasks'}, status=500)


    def post(self, request):
        try:
            serializer = TugasSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save(user=request.user)
                return Response(serializer.data, status=201)
            return Response(serializer.errors, status=400)
        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Failed to create task'}, status=500)


class TugasDetailView(RetrieveUpdateDestroyAPIView):
    permission_classes = [permissions.IsAuthenticated]

    def get_object(self, pk, user):
        try:
            return Tugas.objects.get(pk=pk, user=user)
        except Tugas.DoesNotExist:
            return None

    def put(self, request, pk):
        try:
            tugas = self.get_object(pk, request.user)
            if not tugas:
                return Response({'error': 'Task not found'}, status=404)
            serializer = TugasSerializer(tugas, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data)
            return Response(serializer.errors, status=400)
        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Failed to update task'}, status=500)

    def delete(self, request, pk):
        try:
            tugas = self.get_object(pk, request.user)
            if not tugas:
                return Response({'error': 'Task not found'}, status=404)
            tugas.delete()
            return Response({'message': 'Task deleted'}, status=204)
        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Failed to delete task'}, status=500)

class MarkTugasSelesaiView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def post(self, request, pk):
        try:
            tugas = Tugas.objects.filter(pk=pk, user=request.user).first()
            if not tugas:
                return Response({'error': 'Task not found'}, status=404)
            tugas.selesai = True
            tugas.save()
            return Response({'message': 'Task marked as completed'})
        except Exception as e:
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Failed to mark task'}, status=500)


class TugasStatistikView(APIView):
    permission_classes = [permissions.IsAuthenticated]

    def get(self, request):
        try:
            if request.user.is_anonymous:
                return Response({'error': 'Authentication required'}, status=401)

            today = now().date()
            start_week = today - timedelta(days=today.weekday())
            start_month = today.replace(day=1)

            weekly_completed = Tugas.objects.filter(
                user=request.user,
                selesai=True,
                created_at__date__gte=start_week
            ).count()

            monthly_completed = Tugas.objects.filter(
                user=request.user,
                selesai=True,
                created_at__date__gte=start_month
            ).count()

            return Response({
                'weekly_completed': weekly_completed,
                'monthly_completed': monthly_completed
            })

        except Exception as e:
            sentry_sdk.set_user({"username": str(request.user)})
            sentry_sdk.capture_exception(e)
            return Response({'error': 'Failed to fetch statistics'}, status=500)


