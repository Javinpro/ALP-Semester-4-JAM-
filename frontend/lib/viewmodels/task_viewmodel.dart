import 'package:flutter/material.dart';
import 'package:jam/models/task.dart';
import 'package:jam/services/task_service.dart';

class TaskViewModel extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  List<Task> _tasks = [];
  bool _isLoading = false;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  Future<void> loadTasks(String token) async {
    _isLoading = true;
    notifyListeners();
    print('[ViewModel] loadTasks START');

    try {
      _tasks = await _taskService.fetchUserTasks(token);
      print('[ViewModel] loaded ${_tasks.length} tasks');
    } catch (e, stack) {
      print('[ViewModel] ERROR while fetching tasks: $e');
      print(stack);
    }

    _isLoading = false;
    notifyListeners();
  }


}
