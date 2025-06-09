import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider untuk AuthService
final authServiceProvider = Provider((ref) => AuthService());

class AuthService {
  // Simulasi ID pengguna saat ini
  String getCurrentUserId() {
    return 'user_123'; // Ganti dengan ID pengguna aktual dari sistem otentikasi Anda
  }
}
