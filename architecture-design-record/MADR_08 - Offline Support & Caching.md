---
Status: Accepted
Deciders: Aryo, Javin, Michael
---

# MADR_08 - Offline Support & Caching

## Context and Problem Statement

Aplikasi task list yang sedang dikembangkan harus tetap dapat diakses dan memberikan pengalaman pengguna yang baik meskipun dalam kondisi jaringan yang tidak stabil atau sepenuhnya offline. Untuk itu, diperlukan strategi penyimpanan data lokal (offline support) dan caching agar data penting tetap tersedia tanpa harus selalu bergantung pada koneksi internet.

## Decision Drivers

- Pendekatan offline support & caching yang cocok untuk use case aplikasi.
- Kemampuan tim dalam mengimplementasikan offline support dan caching yang cocok untuk aplikasi.
- Performa dan efisiensi aplikasi dalam menggunakan offline support yang cocok.

## Considered Options

1. HTTP Caching headers
1. Local-first data approach
1. Bespoke caching layer
1. Offline First
1. Online First

## Decision Outcome

**Status: Accepted**
Keputusan: Menggunakan mekanisme Offline first.

### Consequences

- Good:
    - Kemampuan offline-first: pengguna harus tetap bisa melihat data penting (task) tanpa koneksi internet, terutama di area dengan jaringan tidak stabil.
    - Solusi yang dipilih harus mudah diintegrasikan dengan arsitektur aplikasi saat ini (Flutter + REST API)
    - Akses aplikasi tanpa jaringan.
- Bad:
    - Perlu pengujian tambahan untuk skenario offline dan konflik data.
    - Menambah kompleksitas pada layer data access (misalnya penanganan fallback dan validasi data).
    - Harus menetapkan strategi TTL (time-to-live) atau staleness untuk data cache agar tidak kadaluarsa terlalu lama.

## More Information

- Offline support & caching (geekforgeeks): https://www.geeksforgeeks.org/explain-the-benefits-and-challenges-of-caching-and-offline-support-in-redux/
