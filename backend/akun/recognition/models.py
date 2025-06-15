from django.db import models
from django import forms
import os
from django.db import models
from django import forms

class ImageUpload(models.Model):
    image = models.ImageField(upload_to='uploads/')
    uploaded_at = models.DateTimeField(auto_now_add=True)

class ImageUploadForm(forms.ModelForm):
    class Meta:
        model = ImageUpload
        fields = ['image']
        
# Create your models here.
class Video(models.Model):
    title = models.CharField(max_length=100)
    video_file = models.FileField(upload_to='videos')
    filename = models.CharField(max_length=255, default='', editable=False)
    
    def save(self, *args, **kwargs):
        self.filename = os.path.basename(self.video_file.name)
        super().save(*args, **kwargs)
        
    class Meta:
        app_label = 'recognition'
        db_table = 'recognition_video'


class VideoForm(forms.ModelForm):
    class Meta:
        model = Video
        fields = ('title', 'video_file')
