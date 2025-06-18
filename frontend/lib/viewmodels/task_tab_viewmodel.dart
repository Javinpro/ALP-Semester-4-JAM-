import 'package:flutter/material.dart';
import 'package:jam/models/task.dart';
import 'package:jam/services/task_service.dart';
import 'package:jam/services/auth_service.dart'; // ⬅️ tambahkan ini

enum TaskTab { task, todo }

class TaskTabViewModel extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  final AuthService _authService = AuthService(); // ✅ tambahkan


  TaskTab _currentTab = TaskTab.task;
  List<Task> _tasks = [];
  bool _isLoading = false;

  TaskTab get currentTab => _currentTab;
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  void switchTab(TaskTab tab) {
    _currentTab = tab;
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    _isLoading = true;
    notifyListeners();

    try {
      final token = await _authService.getAccessToken();
      final allTasks = await _taskService.fetchUserTasks(token!);
      final all = await _taskService.fetchUserTasks(token!);
      print('🧩 total tasks from server: ${all.length}');
      for (var t in all) {
        print('→ Task id=${t.id}, inTodo=${t.inTodolist}, isCompleted=${t.isCompleted}');
      }
      if (_currentTab == TaskTab.task) {
        _tasks = allTasks
            .where((task) =>
                (task.inTodolist != true) && task.isCompleted != true) // ✅ hide completed
            .toList();
      } else {
        _tasks = allTasks
            .where((task) =>
                task.inTodolist == true && task.isCompleted != true) // ✅ hide completed
            .toList();
      }
    } catch (e) {
      print('Error fetching tasks: $e');
      _tasks = [];
    }

    _isLoading = false;
    notifyListeners();
  }



}
