import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/services/auth_service.dart';

final userProfileProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.fetchUserProfile();
});
