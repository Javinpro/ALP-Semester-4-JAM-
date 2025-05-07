---
Status: Decided
Deciders: Aryo, Javin, Michael
---

# MADR_07 - Theming & UI Styling

## Context and Problem Statement

Putuskan apakah akan membangun sistem desain khusus atau memanfaatkan kemampuan tema Material dan Cupertino milik Flutter untuk memastikan tampilan dan nuansa yang konsisten di seluruh platform.

## Decision Drivers

- Tingkat keahlian tim dalam pengembangan UI Flutter.
- Konsistensi desain antar platform.
- Kebutuhan untuk kustomisasi tampilan di masa depan.

## Considered Options

1. Material Design (untuk Android dan lintas platform)
1. Cupertino (untuk iOS)
1. Membangun *design system* kustom yang dikembangkan sendiri.

## Decision Outcome

**Status: Decided**
Keputusan: Menggunakan Flutter Material Theming sebagai dasar, ditambah dengan pengembangan *design system* kustom di atasnya.

### Consequences

- Good:
    - Selaras dengan tingkat keahlian tim dalam pengembangan UI Flutter, karena tim sudah familiar dengan sistem Material Design dan *theming framework* flutter untuk pengembangan aplikasi android.
- Bad:
    - Kurang sesuai dengan *Human Interface Guidelines* Apple, karena tampilan dan perilaku Material Design tidak sepenuhnya mencerminkan pengalaman native pengguna iOS.

## More Information

- Google Material Design: https://m3.material.io/