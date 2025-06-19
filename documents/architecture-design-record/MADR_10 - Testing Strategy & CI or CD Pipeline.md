---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_10 - Testing Strategy & CI or CD Pipeline

## Context and Problem Statement

Dalam pengembangan proyek ini, dengan Flutter sebagai frontend dan Django sebagai backend, kami dihadapkan pada keterbatasan waktu pengerjaan yang signifikan. Kami menyadari pentingnya testing untuk memastikan kualitas kode. Namun, implementasi CI/CD pipeline yang matang (untuk deployment otomatis dan pengujian berkelanjutan) membutuhkan keperluan waktu dan sumber daya yang tidak sedikit. Fokus utama saat ini adalah untuk segera menghadirkan fitur-fitur inti dan fungsionalitas dasar aplikasi sambil tetap menjaga kualitas dasar melalui testing.

## Decision Drivers

- Proyek memiliki deadline yang singkat, dan setiap menit harus dimanfaatkan secara efisien untuk pengembangan fitur.
- Kami ingin meminimalisir bug kritis dengan mengimplementasikan testing pada level unit dan widget.
- Tim tidak memiliki pengalaman mendalam dalam mengimplementasikan CI/CD pipeline dari awal atau dalam mengembangkan strategi testing yang komprehensif dalam waktu singkat.

## Considered Options

1. Mengimplementasikan unit testing dan widget testing secara terpisah (tidak ada CI/CD).
2. Mengimplementasikan testing dasar (misalnya, hanya unit testing untuk fungsi-fungsi).

## Decision Outcome

**Status: Decided**
Keputusan: Kami akan mengimplementasikan unit testing dan widget testing untuk frontend Flutter dan unit testing untuk backend Django. Kami tidak akan mengimplementasikan CI/CD pipeline pada proyek ini.

### Consequences

Good: 

  - Waktu yang seharusnya dialokasikan untuk penulisan skrip CI/CD, setup environment, troubleshooting pipeline failures, dan maintenance tooling dapat dialihkan sepenuhnya untuk pengembangan fitur dan fungsionalitas inti, memungkinkan deployment manual MVP lebih cepat.
  - Pengurangan kompleksitas setup awal, menyederhanakan onboarding tim dan proses initial setup.

Bad:

  - Deployment manual (baik ke lingkungan staging maupun produksi) sangat bergantung pada tangan manusia, yang meningkatkan risiko kesalahan konfigurasi, build yang tidak konsisten, dan memakan waktu berharga yang seharusnya bisa digunakan untuk pengembangan.
