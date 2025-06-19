---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
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

**Status: Decided**
Decided: Riverpod

### Consequences

Riverpod
- Good:
    - Mengurangi _boilerplate code_ dibandingkan BLoC. Tidak perlu lagi membuat banyak _class_ seperti Event, State, dan Bloc untuk fitur yang simpel.
    - Lebih intuitif dan cepat dipelajari, terutama bila baru mengenal _state management_.
- Bad:
    - Berpotensi membuat kode tidak terstruktur
    - Kurang integrasi langsung dengan package lain dibandingkan "flutter_bloc"

## More Information
- Riverpod: https://riverpod.dev/
