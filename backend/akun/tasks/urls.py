from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import TaskAnswerViewSet, TaskPostViewSet, TaskViewSet, UserProfileView

router = DefaultRouter()
router.register(r'tasks', TaskViewSet, basename='task')
router.register(r'task-posts', TaskPostViewSet, basename='taskpost')
router.register(r'task-answers', TaskAnswerViewSet, basename='taskanswer')

urlpatterns = [
    path('', include(router.urls)),

    # Ini manual, karena UserProfileView adalah APIView (bukan ViewSet)
    path('profile/', UserProfileView.as_view(), name='user-profile'),
]