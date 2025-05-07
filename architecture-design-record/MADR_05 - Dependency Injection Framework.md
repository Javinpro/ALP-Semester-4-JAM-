---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_05 - Dependency Injection Framework

## Context and Problem Statement

Dalam pemilihan Dependency Injection untuk Frontend, kami harus mempertimbangkan waktu karena waktu pengerjaan yang sangat terbatas dan membutuhkan waktu untuk mempelajari Dependency Injection.

## Decision Drivers

- Kurangnya pengalaman dalam menggunakan Dependency Injenction
- Butuh waktu untuk memperlajari Dependency Injection

## Considered Options

1. Tidak menggunakan Dependency Injection
1. GetIt
1. injectable
1. Provider-based injection

## Decision Outcome

**Status: Decided**
Keputusan: Kami tidak menggunakan Dependency Injection

### Consequences

- Good:
    - Cepat dan mudah diterapkan: Tidak perlu setup atau konfigurasi tambahan.
    - Lebih mudah dimengerti oleh tim yang belum familiar dengan DI.
    - Mengurangi kompleksitas awal dalam proyek kecil.

- Bad:
    - Susah dipelihara seiring bertambahnya skala aplikasi.
    - Tight coupling antara class, sulit untuk diuji (testing) atau diubah tanpa memengaruhi bagian lain.
    - Tidak scalable untuk tim besar atau proyek jangka panjang.