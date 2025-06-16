// lib/services/auth_service.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/pages/posting_task/dummy_task_card.dart'; // Untuk mendapatkan currentLoggedInUserId

class AuthService {
  // Metode ini akan mengembalikan ID pengguna yang saat ini login.
  // Dalam aplikasi nyata, ini akan berinteraksi dengan sistem otentikasi (misal Firebase Auth).
  String getCurrentUserId() {
    // Untuk tujuan demo, kita menggunakan ID pengguna dummy yang didefinisikan di dummy_tasks.dart
    return currentLoggedInUserId;
  }
}

// Provider Riverpod untuk AuthService
final authServiceProvider = Provider((ref) => AuthService());
