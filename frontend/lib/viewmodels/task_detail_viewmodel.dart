import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/models/task.dart';
import 'package:jam/services/task_service.dart';

final taskDetailViewModelProvider =
    StateNotifierProvider.family<TaskDetailViewModel, Task?, String>((
      ref,
      taskId,
    ) {
      final taskService = ref.watch(taskServiceProvider);
      return TaskDetailViewModel(taskId, taskService);
    });

class TaskDetailViewModel extends StateNotifier<Task?> {
  final String _taskId;
  final TaskService _taskService;

  TaskDetailViewModel(this._taskId, this._taskService) : super(null) {
    _loadTask();
  }

  void _loadTask() {
    state = _taskService.getTaskById(_taskId);
  }

  // Metode untuk memperbarui state jika ada perubahan dari luar (misal: di-assign)
  void refreshTask() {
    _loadTask();
  }
}
