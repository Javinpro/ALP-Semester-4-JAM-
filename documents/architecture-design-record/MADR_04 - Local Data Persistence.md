---
Status: Decided
Deciders: Javin
Informed: Aryo, Michael
---

# MADR_04 - Local Data Persistence

## Context and Problem Statement

Menentukan mekanisme penyimpanan data untuk dukungan offline dan caching, pilihannya termasuk SQLite, Hive, Sembast, atau ObjectBox, masing-masing dengan kelebihan dan kekurangannya sendiri dalam hal kinerja dan kompleksitas.

## Decision Drivers

- Aplikasi dapat menjadi responsif dan efisien terutama saat beroperasi offline dan menangani potensi data yang signifikan dalam fitur Posting Tugas. 
- Model data berbasis objek dari ObjectBox diharap dapat terintegrasi lebih mulus dengan arsitektur MVVM.
- Fitur Posting Tugas memerlukan pengelolaan relasi antar data yang efektif. ObjectBox dianggap lebih efisien dan mudah dikelola dibandingkan dengan pengelolaan relasi secara manual dengan key-value atau melalui ORM dengan SQLite. 

## Considered Options

1. SQLite
1. Hive
1. Sembast
1. ObjectBox

## Decision Outcome

**Status: Decided**
Keputusan:  memakai SQLite, karena bawaan Django.

### Consequences

SQLite
- Good:
    - sangat cocok untuk potensi kompleksitas dari fitur Posting Tugas. 
    - database yang matang, stabil, dan didukung secara luas di berbagai platform, dan dokumentasi dan sumber daya komunitas yang ekstensif. 
    - menawarkan kemampuan query yang kuat via SQL.
    - tersedia berbagai Object Relational Mapper (ORM), seperti Room, SQLDelight, SwiftData/GRDB, Drift. 
- Bad:
    - penggunaan ORM menambah lapisan abstraksi dan kompleksitas dalam project. 
    - meski fleksibel, menulis dan memelihara query SQL bisa menjadi lebih rumit dibandingkan dengan API query berbasis objek dari ObjectBox. 

## More Information

- Pengertian SQLite: https://www.sqlite.org/
