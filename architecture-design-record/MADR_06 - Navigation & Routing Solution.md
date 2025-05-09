---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_06 - Navigation & Routing Solution

## Context and Problem Statement

Pemilihan Navigation & Routing Solution kami membutuhkan routing yang fleksibel, mudah diatur, dan mendukung navigasi yang kompleks untuk navigasi Aplikasi kami.

## Decision Drivers

- Kebutuhan untuk mendukung struktur navigasi yang kompleks (nested navigation).
- Kebutuhan maintainability dan skalabilitas jangka panjang.

## Considered Options

1. Navigator default Flutter
1. go_router

## Decision Outcome

**Status: Decided**
Keputusan: Kami menggunakan go_router

### Consequences

- Good:
    - Navigasi lebih deklaratif dan terstruktur, cocok untuk arsitektur modern.
    - Mendukung fitur penting seperti redirect, deep linking, dan nested navigation.
    - Dokumentasi yang baik dan telah menjadi solusi resmi yang direkomendasikan oleh tim Flutter.
    - Memudahkan pengelolaan routing di aplikasi besar dengan banyak halaman.

- Bad:
    - Perlu waktu untuk mempelajari sintaks dan konsep baru bagi anggota tim yang terbiasa dengan `Navigator` bawaan.
    - Penambahan dependensi eksternal, yang memerlukan perhatian terhadap kompatibilitas versi Flutter.
