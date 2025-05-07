---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_01 - App Architecture Pattern

## Context and Problem Statement

Memilih architectural pattern yang akan digunakan untuk pengembangan aplikasi. Diperlukan pemilihan pola arsitektur aplikasi yang akan digunakan sebagai fondasi struktur kode, terutama dalam pemisahan tanggung jawab antara UI, logika presentasi, dan logika bisnis.

## Decision Drivers

- Kemudahan pemeliharaan dan pengujian
- Skalabilitas sistem di masa depan
- Dukungan terhadap modularitas dan fleksibilitas teknologi
- Pengalaman tim dengan pola arsitektur tertentu

## Considered Options

1. Model View Controller Pattern (MVC)
1. Model View Presenter Pattern (MVP)
1. Model View ViewModel Pattern (MVVM)
1. Clean Architecture
1. Hexagonal (ports & adapters)

## Decision Outcome

**Status: Decided**
Keputusan: Menggunakan architectural pattern MVVM atau Model View ViewModel

### Consequences

- Good:
    - Tidak perlu mengembangkan controller dan dapat secara langsung menggunakan dan mengendalikan data di dalam tampilan
- Bad:
    - Penggunaan MVVC untuk aplikasi simpel mungkin tidak cocok.

## More Information

- Model View ViewModel pattern: https://learn.microsoft.com/en-us/dotnet/architecture/maui/mvvm