---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_03 - Backend Integration Approach

## Context and Problem Statement

Sistem yang sedang dikembangkan memerlukan komunikasi antara beberapa komponen layanan (misalnya frontend dan backend) dan dibutuhkan pendekatan integrasi backend agar bisa berkomunikasi dengan frontend.

## Decision Drivers

- Kesesuaian dengan kebutuhan komunikasi aplikasi
- Pengalaman tim dengan backend integration tertentu
- Kompatibilitas antar platform

## Considered Options

1. RESTful API
1. GraphQL
1. Firebase

## Decision Outcome

**Status: Decided**
Keputusan: Menggunakan REST (Representational State Transfer) sebagai *backend integration*

### Consequences

- Good:
    - Kesederhanaan dan adopsi luas, REST adalah pendekatan yang paling umum digunakan, banyak didukung oleh berbagai framework dan pustaka.
    - Mendukung arsitektur yang skalabel karena tidak menyimpan status pada server.
    - Dokumentasi yang relatif gampang dengan Swagger/OpenAPI.
- Bad:
    - Layanan backend perlu merancang dan mendokumentasikan API secara detail.
    - Perlu perhatian khusus pada versi API dan error handling.

## More Information

- Pengertian RESTful API: https://aws.amazon.com/id/what-is/restful-api/