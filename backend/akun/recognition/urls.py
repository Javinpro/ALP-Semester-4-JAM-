from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from . import views

urlpatterns = [
    path("recognition", views.recognition, name="recognition"),
    path('detect-image/', views.detect_image, name='detect_image'),
    path('verify-form/', views.verify_form, name='verify_form'),
    path('verify-object/', views.verify_object, name='verify_object')
]+ static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)

urlpatterns += static(settings.STATIC_URL, document_root=settings.STATIC_ROOT)
