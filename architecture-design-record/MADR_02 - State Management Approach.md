---
Status: Proposed
Deciders: Aryo, Javin, Michael
---

# MADR_02 - State Management Approach

## Context and Problem Statement

Pemilihan pendekatan state management untuk pengembangan aplikasi. Pemilihan harus mempertimbangkan kebutuhan kompleksitas aplikasi dan preferensi maintainability jangka panjang.  

## Decision Drivers

- Dukungan komunitas dan kelengkapan dokumentasi
- Kemampuan tim dalam menggunakan pendekatan state management

## Considered Options

1. Provider
1. BLoC (Bussiness Logic Component)
1. Riverpod

## Decision Outcome

**Status: Proposed**
Proposed: Menggunakan Bussiness Logic Component (BloC) atau Riverpod

### Consequences

BLoC
- Good:
    - Pisah tegas antara event, state, dan business logic, ideal untuk proyek yang akan besar
    - Widget seperti BlocBuilder, BlocListener membuat UI lebih mudah mengamati dan merespons perubahan state.
- Bad:
    - Perlu banyak file (event, state, bloc) bahkan untuk logika yang simpel.
    - Berpotensi *overkill* untuk aplikasi sederhana.

Riverpod
- Good:
    - State diatur dengan pendekatan deklaratif, mendukung berbagai jenis state (sync, async, computed).
    - Bisa digunakan untuk berbagai gaya manajemen state (global/local state, reactive side effect, dll).
    - Tidak perlu banyak file untuk mengatur state.
- Bad:
    - Berpotensi membuat kode tidak terstruktur
    - Kurang integrasi langsung dengan package lain dibandingkan "flutter_bloc"

## More Information

- BLoC: https://bloclibrary.dev/getting-started/
- Riverpod: https://riverpod.dev/
