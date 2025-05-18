# akun/urls.py

from django.urls import path
from .views import RegisterView, LoginView, LogoutView, ProfileUpdateView, TugasListCreateView, TugasDetailView, MarkTugasSelesaiView, TugasStatistikView


urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', LoginView.as_view(), name='login'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('profile/update/', ProfileUpdateView.as_view(), name='profile-update'),

    # CRUD Tugas
    path('tampil/', TugasListCreateView.as_view(), name='list-create-tugas'),
    path('tugas/', TugasListCreateView.as_view(), name='tugas-list-create'),
    path('tugas/<int:pk>/', TugasDetailView.as_view(), name='tugas-detail'),
    path('<int:pk>/selesai/', MarkTugasSelesaiView.as_view(), name='mark-tugas-selesai'),
    path('statistik/', TugasStatistikView.as_view(), name='statistik-tugas'),
]
