from django.urls import path
from .views import CustomTokenObtainPairView, RegisterView, ProfileUpdateView, ProfileDetailView, LogoutView
from rest_framework_simplejwt.views import TokenObtainPairView, TokenRefreshView

urlpatterns = [
    path('register/', RegisterView.as_view(), name='register'),
    path('login/', CustomTokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('logout/', LogoutView.as_view(), name='logout'),
    path('profile/', ProfileDetailView.as_view(), name='profile-detail'),
    path('profile/edit/', ProfileUpdateView.as_view(), name='profile-edit'),
    path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
]
