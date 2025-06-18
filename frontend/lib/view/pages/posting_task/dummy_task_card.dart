// // lib/data/dummy_tasks.dart
// import 'package:jam/models/task.dart';
// import 'package:jam/models/task_difficulty.dart';
// import 'package:uuid/uuid.dart';

// // Asumsikan ini adalah ID pengguna yang sedang login untuk "Your Tasks"
// const String currentLoggedInUserId = 'my_user_id_123';
// final Uuid _uuid = Uuid(); // Inisialisasi Uuid

// final List<Task> allDummyTasks = [
//   // --- Your Tasks (Tugas yang Anda posting) ---
//   Task(
//     id: _uuid.v4(),
//     userId: currentLoggedInUserId,
//     taskName: 'Desain Logo Baru untuk Aplikasi',
//     description:
//         'Mendesain logo modern dan minimalis untuk aplikasi mobile JAM. Preferensi warna cerah.',
//     deadline: DateTime(
//       2025,
//       6,
//       23,
//       10,
//       0,
//     ), // Contoh deadline: 23 Juni 2025, 10:00
//     difficulty: TaskDifficulty.hard,
//     photoPath:
//         null, // Bisa diisi 'assets/images/logo_design_example.png' jika ada
//     assignedToUserId: null, // Belum di-assign
//   ),
//   Task(
//     id: _uuid.v4(),
//     userId: currentLoggedInUserId,
//     taskName: 'Membuat Konten Blog (3 Artikel)',
//     description:
//         'Menulis 3 artikel blog tentang tips manajemen waktu untuk pelajar. Minimal 800 kata per artikel.',
//     deadline: DateTime(
//       2025,
//       6,
//       30,
//       15,
//       30,
//     ), // Contoh deadline: 30 Juni 2025, 15:30
//     difficulty: TaskDifficulty.easy,
//     photoPath: null,
//     assignedToUserId: 'other_user_id_A', // Contoh sudah di-assign ke user lain
//   ),
//   Task(
//     id: _uuid.v4(),
//     userId: currentLoggedInUserId,
//     taskName: 'Perbaikan Sistem Jaringan Kantor',
//     description:
//         'Melakukan troubleshooting dan perbaikan koneksi jaringan LAN di kantor utama.',
//     deadline: DateTime(
//       2025,
//       6,
//       19,
//       9,
//       0,
//     ), // Contoh deadline: 19 Juni 2025, 09:00
//     difficulty: TaskDifficulty.hard,
//     photoPath: null, // Bisa diisi 'assets/images/network_issue.png' jika ada
//     assignedToUserId: null,
//   ),
//   Task(
//     id: _uuid.v4(),
//     userId: currentLoggedInUserId,
//     taskName: 'Mengorganisir Dokumen Fisik',
//     description:
//         'Mengurutkan dan mengarsipkan dokumen-dokumen lama di gudang arsip.',
//     deadline: DateTime(
//       2025,
//       6,
//       21,
//       17,
//       0,
//     ), // Contoh deadline: 21 Juni 2025, 17:00
//     difficulty: TaskDifficulty.easy,
//     photoPath: null,
//     assignedToUserId: null,
//   ),

//   // --- Others Tasks (Tugas yang diposting oleh orang lain) ---
//   Task(
//     id: _uuid.v4(),
//     userId: 'user_alpha_456',
//     taskName: 'Bantu mengerjakan laporan keuangan bulanan',
//     description:
//         'Perlu bantuan untuk merekonsiliasi data transaksi dan membuat draft laporan keuangan Juli.',
//     deadline: DateTime(
//       2025,
//       6,
//       20,
//       11,
//       0,
//     ), // Contoh deadline: 20 Juni 2025, 11:00
//     difficulty: TaskDifficulty.hard,
//     photoPath: null,
//     assignedToUserId: null, // Belum di-assign
//   ),
//   Task(
//     id: _uuid.v4(),
//     userId: 'user_beta_789',
//     taskName: 'Belanja bahan makanan untuk acara BBQ',
//     description:
//         'Daftar lengkap akan diberikan. Prioritas daging segar dan sayuran untuk BBQ.',
//     deadline: DateTime(
//       2025,
//       6,
//       17,
//       14,
//       0,
//     ), // Contoh deadline: 17 Juni 2025, 14:00
//     difficulty: TaskDifficulty.easy,
//     photoPath: null,
//     assignedToUserId: null,
//   ),
//   Task(
//     id: _uuid.v4(),
//     userId: 'user_gamma_012',
//     taskName: 'Menterjemahkan dokumen dari Inggris ke Indonesia',
//     description:
//         'Dokumen teknis sekitar 50 halaman. Diperlukan akurasi tinggi.',
//     deadline: DateTime(
//       2025,
//       6,
//       26,
//       9,
//       30,
//     ), // Contoh deadline: 26 Juni 2025, 09:30
//     difficulty: TaskDifficulty.hard,
//     photoPath: null,
//     assignedToUserId: null,
//   ),
//   Task(
//     id: _uuid.v4(),
//     userId: 'user_delta_345',
//     taskName: 'Mencari rekomendasi tempat wisata di Makassar',
//     description:
//         'Ingin liburan singkat 3 hari 2 malam. Cari tempat menarik yang ramah keluarga.',
//     deadline: DateTime(
//       2025,
//       6,
//       18,
//       16,
//       0,
//     ), // Contoh deadline: 18 Juni 2025, 16:00
//     difficulty: TaskDifficulty.easy,
//     photoPath: null,
//     assignedToUserId: null,
//   ),
//   Task(
//     id: _uuid.v4(),
//     userId: 'user_epsilon_678',
//     taskName: 'Membantu instalasi OS Linux di Laptop',
//     description:
//         'Laptop lama ingin diinstal Linux Ubuntu. Perlu bantuan untuk partisi dan instalasi.',
//     deadline: DateTime(
//       2025,
//       6,
//       17,
//       10,
//       0,
//     ), // Contoh deadline: 17 Juni 2025, 10:00
//     difficulty: TaskDifficulty.hard,
//     photoPath: null,
//     assignedToUserId: currentLoggedInUserId, // Contoh sudah di-assign ke "Anda"
//   ),
// ];

// // Helper function untuk mendapatkan "Your Tasks"
// List<Task> getYourPostedTasks() {
//   return allDummyTasks
//       .where((task) => task.userId == currentLoggedInUserId)
//       .toList();
// }

// // Helper function untuk mendapatkan "Others Tasks" (yang diposting oleh orang lain DAN belum di-assign)
// List<Task> getOthersPostedTasks() {
//   return allDummyTasks
//       .where(
//         (task) =>
//             task.userId != currentLoggedInUserId &&
//             task.assignedToUserId == null,
//       )
//       .toList();
// }

// // Helper function untuk mendapatkan semua tugas yang belum di-assign (untuk halaman SelectTaskPage)
// List<Task> getUnassignedTasks() {
//   return allDummyTasks.where((task) => task.assignedToUserId == null).toList();
// }
