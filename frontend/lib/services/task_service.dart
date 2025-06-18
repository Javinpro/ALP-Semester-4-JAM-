import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jam/models/task.dart';
import 'package:jam/services/auth_service.dart';

class TaskService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/tasks';
  final AuthService _authService = AuthService(); // ✅ Tambahkan ini

  Future<List<Task>> fetchUserTasks(String token) async {
    final url = 'http://127.0.0.1:8000/api/tasks/';
    print('[Service] GET $url');
    print('[Service] Authorization: Bearer $token');

    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    print('[Service] statusCode=${response.statusCode}');
    print('[Service] body=${response.body}');

    if (response.statusCode == 200) {
      try {
        final List<dynamic> data = json.decode(response.body);
        return data.map((e) {
          print('[Service] parsing: $e');
          return Task.fromJson(e);
        }).toList();
      } catch (e) {
        print('[Service] ERROR saat parsing JSON: $e');
        rethrow;
      }
    } else {
      throw Exception("Gagal fetch task (${response.statusCode})");
    }
}

Future<List<Task>> fetchTodoTasks(String token) async {
  final url = 'http://127.0.0.1:8000/api/tasks/in_todolist/';
  final response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer $token'},
  );

  if (response.statusCode == 200) {
    final List data = jsonDecode(response.body);
    return data.map((e) => Task.fromJson(e)).toList();
  } else {
    throw Exception('Gagal load todo');
  }
}

Future<bool> deleteTask(int id) async {
  final token = await _authService.getAccessToken(); // ✅ akses token dengan benar
  final response = await http.delete(
    Uri.parse('$baseUrl/$id/'),
    headers: {'Authorization': 'Bearer $token'},
  );
  return response.statusCode == 204;
}

Future<bool> addToTodolist(int id) async {
  final token = await _authService.getAccessToken(); // ✅ akses token dengan benar
  final response = await http.post(
    Uri.parse('$baseUrl/$id/add_to_todolist/'),
    headers: {'Authorization': 'Bearer $token'},
  );
  return response.statusCode == 200;
}

Future<bool> markComplete(int id) async {
  final token = await _authService.getAccessToken();
  final response = await http.post(
    Uri.parse('$baseUrl/$id/complete/'),
    headers: {'Authorization': 'Bearer $token'},
  );
  return response.statusCode == 200;
}

Future<bool> updateTask({
  required int id,
  required String title,
  required String description,
  required String deadline,
}) async {
  final token = await _authService.getAccessToken();
  final response = await http.patch(
    Uri.parse('$baseUrl/$id/'),
    body: jsonEncode({
      'title': title,
      'description': description,
      'deadline': deadline,
    }),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
  );
  return response.statusCode == 200;
}

Future<bool> createTask({
  required String title,
  required String description,
  required String deadline,
}) async {
  final token = await _authService.getAccessToken();
  print('[CREATE] token = $token');

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'deadline': deadline,
      }),
    );

    print('[CREATE] status = ${response.statusCode}');
    print('[CREATE] body = ${response.body}');

    return response.statusCode == 201;
  } catch (e) {
    print('[CREATE] ERROR = $e');
    return false;
  }
}

Future<bool> removeFromTodolist(int id) async {
  final token = await _authService.getAccessToken(); // ✅ akses token dengan benar
  final response = await http.post(
    Uri.parse('$baseUrl/$id/remove_from_todolist/'),
    headers: {'Authorization': 'Bearer $token'},
  );
  return response.statusCode == 200;
}

}
