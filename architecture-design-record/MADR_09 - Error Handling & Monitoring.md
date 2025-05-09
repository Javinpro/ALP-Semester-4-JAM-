---
Status: Proposed
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_09 - Error Handling & Monitoring

## Context and Problem Statement

mengimplementasikan penanganan kesalahan dan pemantauan yang kuat, melibatkan alat yang tepat untuk menangkap exception, melacak crash, dan memantau kinerja keseluruhan aplikasi. 

## Decision Drivers

- kebutuhan untuk menangkap dan menganalisis crash secara efektif di aplikasi mobile untuk memastikan stabilitas dan pengalaman pengguna yang baik.
- penting untuk memiliki sistem yang dapat secara terpusat melacak dan melaporkan kesalahan yang terjadi di sisi backend Laravel, serta memberikan pemberitahuan proaktif untuk masalah kritis.
- alat yang dipilih harus mudah diintegrasikan dengan teknologi yang sudah digunakan, yaitu aplikasi mobile (potensial dengan Firebase) dan backend Laravel.
- alat harus menyediakan informasi yang cukup detail (seperti stack trace, informasi request, konteks) untuk memudahkan analisis penyebab kesalahan dan proses debugging.

## Considered Options

1. Sentry 
1. Firebase Crashlytics 
1. Custom Logging 

## Decision Outcome

**Status: Proposed**
Keputusan: masih mengusulkan untuk menggunakan Firebase Crashlytics untuk pelaporan kesalahan dan analisis crash, dan mengimplementasikan solusi Logging bawaan Laravel dan Sentry untuk pemantauan aplikasi dan debugging yang detail.

### Consequences

Firebase Crashlytics
- Good:
    - menyediakan laporan crash yang detail, termasuk stack trace, informasi perangkat, dan dampak pengguna, sehingga memudahkan identifikasi dan diagnosis masalah kritis. 
    - menawarkan pelaporan crash hampir secara real-time, memungkinkan kesadaran cepat terhadap masalah kritis yang memengaruhi pengguna. 
    - terintegrasi dengan mulus dengan layanan Firebase lain yang mungkin kita gunakan (misalnya, Analytics), menyediakan platform terpadu untuk pemantauan aplikasi.
    - memungkinkan pengelompokan crash berdasarkan versi build, perangkat, dan segmen pengguna, membantu dalam memprioritaskan perbaikan.
- Bad:
    - meskipun memungkinkan penambahan kunci dan log kustom ke laporan crash, alat ini tidak dirancang terutama untuk logging tingkat aplikasi yang detail dan pemantauan peristiwa non-fatal. 

Logging bawaan Laravel
- Good:
    - menyediakan sistem logging bawaan yang mudah digunakan untuk mencatat berbagai peristiwa, kesalahan, dan aktivitas aplikasi backend ke file, database, atau layanan lainnya. 
    - relatif sederhana.
- Bad:
    - menganalisis log dari file atau database secara manual bisa menjadi sulit dan kurang efisien untuk mengidentifikasi tren atau masalah yang kompleks.
    - pemberitahuannya terbatas, yang dimana tidak secara otomatis memberikan pemberitahuan proaktif tentang kesalahan kritis.

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

- Pengertian Firebase Crashlytics: https://firebase.google.com/docs/crashlytics?hl=id
- Pengertian Sentry: https://sentry.io/
- Pengertian Logging Laravel: https://www.domainesia.com/berita/laravel-adalah/