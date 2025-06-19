---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_09 - Error Handling & Monitoring

## Context and Problem Statement

mengimplementasikan penanganan kesalahan dan pemantauan yang kuat, melibatkan alat yang tepat untuk menangkap exception, melacak crash, dan memantau kinerja keseluruhan aplikasi. 

## Decision Drivers

- kebutuhan untuk menangkap dan menganalisis crash secara efektif di aplikasi mobile untuk memastikan stabilitas dan pengalaman pengguna yang baik.
- penting untuk memiliki sistem yang dapat secara terpusat melacak dan melaporkan kesalahan yang terjadi di sisi backend, serta memberikan pemberitahuan proaktif untuk masalah kritis.
- alat yang dipilih harus mudah diintegrasikan dengan teknologi yang sudah digunakan, yaitu aplikasi mobile (potensial dengan Firebase) dan backend django.
- alat harus menyediakan informasi yang cukup detail (seperti stack trace, informasi request, konteks) untuk memudahkan analisis penyebab kesalahan dan proses debugging.

## Considered Options

1. Sentry 
1. Firebase Crashlytics 
1. Custom Logging 

## Decision Outcome

**Status: Decided**
Keputusan: memakai Sentry.

### Consequences

Sentry 
- Good:
    - dirancang untuk melacak dan melaporkan kesalahan di aplikasi backend secara terpusat, menyediakan stack trace yang detail, informasi request, dan konteks lainnya. 
    - dapat dikonfigurasi untuk memberikan pemberitahuan real-time tentang kesalahan kritis melalui berbagai saluran (email, Slack, dll).
    - menyediakan antarmuka web yang kaya untuk menganalisis tren kesalahan, mengidentifikasi masalah yang sering terjadi, dan melacak perbaikan.
    - memiliki integrasi yang baik dengan framework Laravel, memudahkan penangkapan dan pelaporan pengecualian.
- Bad:
    - biasanya memiliki biaya berlangganan setelah melampaui batas paket gratisnya.
    - memerlukan konfigurasi dan integrasi tambahan ke dalam aplikasi Laravel.

## More Information

- Pengertian Sentry: https://sentry.io/
