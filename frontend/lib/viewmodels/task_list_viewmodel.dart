import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/models/answer.dart';
import 'package:jam/models/task.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/services/task_service.dart';

// Provider untuk PostedTasksViewModel
final postedTasksViewModelProvider =
    StateNotifierProvider<TaskListViewModel, List<Task>>((ref) {
      final taskService = ref.watch(taskServiceProvider);
      final authService = ref.watch(authServiceProvider);
      return TaskListViewModel(
        taskService,
        authService,
        filterType: TaskFilterType.posted,
      );
    });

// Provider untuk DoingTasksViewModel
final doingTasksViewModelProvider =
    StateNotifierProvider<TaskListViewModel, List<Task>>((ref) {
      final taskService = ref.watch(taskServiceProvider);
      final authService = ref.watch(authServiceProvider);
      return TaskListViewModel(
        taskService,
        authService,
        filterType: TaskFilterType.doing,
      );
    });

enum TaskFilterType { posted, doing }

class TaskListViewModel extends StateNotifier<List<Task>> {
  final TaskService _taskService;
  final AuthService _authService;
  final TaskFilterType _filterType;

  TaskListViewModel(
    this._taskService,
    this._authService, {
    required TaskFilterType filterType,
  })  : _filterType = filterType,
        super([]) {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final allTasks = _taskService.getTasks();
    final currentUserId = await _authService.getCurrentUserId();

    if (currentUserId == null) {
      print("Gagal mendapatkan user ID saat load tasks.");
      state = [];
      return;
    }

    if (_filterType == TaskFilterType.posted) {
      state = allTasks.where((task) => task.userId == currentUserId).toList();
    } else if (_filterType == TaskFilterType.doing) {
      state = allTasks
          .where((task) => task.assignedToUserId == currentUserId)
          .toList();
    }
  }

  Future<void> refreshTasks() async {
    await _loadTasks();
  }

  Future<void> assignTaskToCurrentUser(String taskId) async {
    final task = _taskService.getTaskById(taskId);
    final userId = await _authService.getCurrentUserId();
    if (task != null && task.assignedToUserId == null && userId != null) {
      final updatedTask = task.copyWith(assignedToUserId: userId);
      _taskService.updateTask(updatedTask);
      await refreshTasks();
    }
  }

  List<Answer> getAnswersForTask(String taskId) {
    return _taskService.getAnswersForTask(taskId);
  }
}
