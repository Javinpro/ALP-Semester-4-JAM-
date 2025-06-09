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
  }) : _filterType = filterType,
       super([]) {
    _loadTasks();
  }

  void _loadTasks() {
    final allTasks = _taskService.getTasks();
    final currentUserId = _authService.getCurrentUserId();

    if (_filterType == TaskFilterType.posted) {
      state = allTasks.where((task) => task.userId == currentUserId).toList();
    } else if (_filterType == TaskFilterType.doing) {
      state =
          allTasks
              .where((task) => task.assignedToUserId == currentUserId)
              .toList();
    }
  }

  // Dipanggil saat ada perubahan pada task service (misal: task baru diposting, task di-assign)
  void refreshTasks() {
    _loadTasks();
  }

  // Fungsi untuk meng-assign tugas kepada user (untuk tombol "Do this task")
  void assignTaskToCurrentUser(String taskId) {
    final task = _taskService.getTaskById(taskId);
    if (task != null && task.assignedToUserId == null) {
      final updatedTask = task.copyWith(
        assignedToUserId: _authService.getCurrentUserId(),
      );
      _taskService.updateTask(updatedTask);
      refreshTasks(); // Refresh list to reflect changes
      // Jika ini adalah ViewModel untuk 'Doing', ia akan otomatis update.
      // Jika ini adalah ViewModel untuk 'Posted', ia akan tetap sama.
    }
  }

  // Fungsi untuk mendapatkan jawaban terkait tugas yang sedang dikerjakan (untuk halaman 'Doing')
  List<Answer> getAnswersForTask(String taskId) {
    return _taskService.getAnswersForTask(taskId);
  }
}
