from django.conf import settings
from django.shortcuts import render
from .models import VideoForm, Video
from .utils import detect_objects_in_video
from django.shortcuts import render
from .models import ImageUploadForm
from ultralytics import YOLO
import cv2
import os
from django.core.files.storage import default_storage
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import random
from PIL import Image

model = YOLO('yolov8s.pt')

POSSIBLE_OBJECTS = ['book', 'bottle']

from django.http import JsonResponse
from ultralytics import YOLO
import cv2

model = YOLO("yolov8s.pt")

def verify_form(request):
    object_choices = ['book', 'bottle']
    expected_object = random.choice(object_choices)
    return render(request, 'verify_object.html', {'expected_object': expected_object})



@csrf_exempt
def verify_object(request):
    if request.method == "POST" and request.FILES.get("image") and request.POST.get("expected_object"):
        image_file = request.FILES["image"]
        expected_object = request.POST["expected_object"].lower()

        img = Image.open(image_file)
        results = model(img)
        names = model.names

        detected_labels = [names[int(box.cls)] for box in results[0].boxes]

        print("Deteksi objek:", detected_labels)
        print("Objek yang diminta:", expected_object)

        if expected_object.lower() in [label.lower() for label in detected_labels]:
            result = f"✅ Objek {expected_object} terdeteksi. Alarm dimatikan!"
        else:
            result = f"❌ Objek {expected_object} tidak ditemukan. Silakan upload ulang."

        return render(request, "verify_object.html", {
            "expected_object": expected_object,
            "result": result
        })
    else:
        return JsonResponse({"error": "Missing image or expected_object"})



def detect_image(request):
    result_url = None
    image_url = None
    detected_objects = []

    if request.method == 'POST':
        form = ImageUploadForm(request.POST, request.FILES)
        if form.is_valid():
            image = form.cleaned_data['image']
            img_obj = form.save()

            img_path = img_obj.image.path
            image_url = img_obj.image.url
            img = cv2.imread(img_path)

            results = model.predict(source=img, imgsz=640)
            result = results[0]
            annotated = result.plot()

            # Buat folder jika belum ada
            annotated_dir = os.path.join(settings.MEDIA_ROOT, 'uploads', 'annotated')
            os.makedirs(annotated_dir, exist_ok=True)
            filename = os.path.basename(img_path)
            out_path = os.path.join(annotated_dir, filename)
            cv2.imwrite(out_path, annotated)
            result_url = settings.MEDIA_URL + f'uploads/annotated/{filename}'

            for box in result.boxes:
                cls_id = int(box.cls[0])
                name = result.names[cls_id]
                detected_objects.append(name)
    else:
        form = ImageUploadForm()

    return render(request, 'detect_image.html', {
        'form': form,
        'result': result_url,
        'image_url': image_url,
        'detected_objects': detected_objects,
    })

def recognition(request):
    if request.method == 'POST':
        form = VideoForm(request.POST, request.FILES)
        if form.is_valid():
            instance = form.save()
            video_path = instance.video_file.path
            detect_objects_in_video(video_path, instance.pk)
    else:
        form = VideoForm()
    
    detected_objs = Video.objects.all()
        
    return render(request, 'recognition.html', {"form": form, "detected_objs": detected_objs})
