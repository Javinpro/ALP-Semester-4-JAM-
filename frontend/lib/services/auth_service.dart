import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider = Provider((ref) => AuthService());

class AuthService {
  final _dio = Dio();
  final _storage = const FlutterSecureStorage();

  final String baseUrl = 'http://127.0.0.1:8000/api/accounts';

  // Login user dan simpan token + user_id
  Future<bool> login(String username, String password) async {
    final url = '$baseUrl/login/';
    try {
      final response = await _dio.post(
        url,
        data: {'username': username, 'password': password},
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['access'];
        final refreshToken = response.data['refresh'];
        final userId = response.data['user_id']; // pastikan backend kirim ini

        print('[LOGIN] userId = $userId');
        
        await _storage.write(key: 'access_token', value: accessToken);
        await _storage.write(key: 'refresh_token', value: refreshToken);
        await _storage.write(
          key: 'user_id',
          value: userId.toString(),
        ); // simpan user ID
        return true;
      }
    } catch (e) {
      print('Login error: $e');
    }
    return false;
  }

  

  // Logout user
  Future<bool> logout() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    final accessToken = await _storage.read(key: 'access_token');

    if (refreshToken == null || accessToken == null) return false;

    final url = '$baseUrl/logout/';
    try {
      final response = await _dio.post(
        url,
        data: {'refresh': refreshToken},
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      if (response.statusCode == 205) {
        await _storage.deleteAll();
        return true;
      }
    } catch (e) {
      print('Logout error: $e');
    }
    return false;
  }

  // Ambil token access saat ini
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  // Ambil user ID yang sedang login
  Future<String?> getCurrentUserId() async {
    final id = await _storage.read(key: 'user_id');
    print('[AuthService] fetched user_id from storage: $id');
    return id;
  }


  // Refresh access token (opsional)
  Future<void> refreshAccessToken() async {
    final refreshToken = await _storage.read(key: 'refresh_token');
    if (refreshToken == null) return;

    try {
      final response = await _dio.post(
        '$baseUrl/token/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        await _storage.write(
          key: 'access_token',
          value: response.data['access'],
        );
      }
    } catch (e) {
      print('Refresh token error: $e');
    }
  }

  Future<Map<String, dynamic>> fetchUserProfile() async {
    final token = await _storage.read(key: 'access_token');
    if (token == null) throw Exception("No token found");

    final response = await _dio.get(
      '$baseUrl/profile/',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return response.data;
  }

  Future<bool> register({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final url = '$baseUrl/register/';
    try {
      final response = await _dio.post(
        url,
        data: {
          'username': username,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
        },
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  Future<bool> updateProfile({
    required String firstName,
    required String lastName,
    required String username,
    String? password,
  }) async {
    final token = await _storage.read(key: 'access_token');
    if (token == null) return false;

    final data = {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
    };

    if (password != null && password.isNotEmpty) {
      data['password'] = password;
    }

    final response = await _dio.patch(
      '$baseUrl/profile/edit/',
      data: data,
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    return response.statusCode == 200;
  }

}
