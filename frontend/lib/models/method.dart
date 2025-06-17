import 'package:flutter/foundation.dart';

@immutable
class Method {
  final String id;
  final String title;
  final String title2; // Short explanation
  final String title3; // Short explanation
  final String description; // Full description
  final String imagePath;
  final int studyDurationSeconds; // Durasi belajar default
  final int restDurationSeconds; // Durasi istirahat default

  const Method({
    required this.id,
    required this.title,
    required this.title2,
    required this.title3,
    required this.description,
    required this.imagePath,
    required this.studyDurationSeconds,
    required this.restDurationSeconds,
  });

  // Contoh data statis (bisa juga dari service)
  static const List<Method> defaultMethods = [
    Method(
      id: 'pomodoro',
      title: 'Pomodoro',
      title2: 'Fokus 25 menit, istirahat 5 menit.',
      title3: 'Cara metodenya : ',
      description:
          '1. Fokus sepenuhnya pada tugas tanpa gangguan selama 25 menit. \n'
          '2. Gunakan waktu istirahat 10 menit untuk meregangkan tubuh, minum air, atau melakukan aktivitas santai. \n'
          '3. Ulangi proses sampai tugas selesai.',
      imagePath: 'assets/img/Pomodoro.jpg', // Ganti dengan path gambar Anda
      studyDurationSeconds: 0 * 60,
      restDurationSeconds: 0 * 60,
    ),
    Method(
      id: 'metode_52_17',
      title: 'Metode 52-17',
      title2: 'Fokus 52 menit, istirahat 17 menit.',
      title3: 'Cara metodenya : ',
      description:
          '1. Fokus sepenuhnya pada tugas tanpa gangguan selama 52 menit. \n'
          '2. Gunakan waktu istirahat 17 menit untuk meregangkan tubuh, minum air, atau melakukan aktivitas santai. \n'
          '3. Ulangi proses sampai tugas selesai.',
      imagePath: 'assets/img/Metode 5217.jpg', // Ganti dengan path gambar Anda
      studyDurationSeconds: 52 * 60,
      restDurationSeconds: 17 * 60,
    ),
    Method(
      id: 'ultradian_rhythm',
      title: 'Ultradian Rhythm',
      title2: 'Fokus 90 menit, istirahat 30 menit.',
      title3: 'Cara metodenya : ',
      description:
          '1. Fokus sepenuhnya pada tugas tanpa gangguan selama 90 menit. \n'
          '2. Gunakan waktu istirahat 30 menit untuk meregangkan tubuh, minum air, atau melakukan aktivitas santai. \n'
          '3. Ulangi proses sampai tugas selesai.',
      imagePath:
          'assets/img/Ultradian Rhythm.jpg', // Ganti dengan path gambar Anda
      studyDurationSeconds: 90 * 60,
      restDurationSeconds: 30 * 60,
    ),
  ];
}
