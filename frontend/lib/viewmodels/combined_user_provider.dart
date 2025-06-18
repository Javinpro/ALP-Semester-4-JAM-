import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/services/auth_service.dart';

final userTokenAndIdProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final auth = ref.read(authServiceProvider);
  final token = await auth.getAccessToken();
  final userId = await auth.getCurrentUserId();

  print('[Provider] token=$token, userId=$userId');

  if (token == null || userId == null) {
    throw Exception('Token atau User ID tidak tersedia');
  }

  return {
    'token': token,
    'user_id': int.parse(userId),
  };
});
