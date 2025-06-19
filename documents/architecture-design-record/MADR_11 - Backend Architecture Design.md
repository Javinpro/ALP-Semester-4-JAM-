---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_11 - Backend Architecture

## Context and Problem Statement

Memilih architectural pattern yang akan digunakan untuk pengembangan backend aplikasi. Diperlukan pemilihan pola arsitektur aplikasi yang akan digunakan sebagai fondasi struktur kode, terutama dalam pemisahan tanggung jawab antara UI, Model, dan Controller.

## Decision Drivers

- Kustomisasi mudah
- Penggunaan Kembali Kode
- Performa tinggi

## Considered Options

1. Model View Template (MVT)

## Decision Outcome

**Status: Decided**
Keputusan: Menggunakan architectural pattern MVT

### Consequences

- Good:
    - MVT memisahkan logika data (Model), logika aplikasi (View), dan tampilan pengguna (Template), sehingga memungkinkan pengembangan dan pemeliharaan yang lebih mudah dan terstruktur
- Bad:
    - Kurva Pembelajaran Awal.
