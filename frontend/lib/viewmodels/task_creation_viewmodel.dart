import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jam/models/task.dart';
import 'package:jam/models/task_difficulty.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/services/task_service.dart';
import 'package:jam/viewmodels/common_providers.dart';
import 'package:jam/viewmodels/task_list_viewmodel.dart'; // Untuk refresh task list

final taskCreationViewModelProvider =
    StateNotifierProvider.autoDispose<TaskCreationViewModel, Task>((ref) {
      final authService = ref.watch(authServiceProvider);
      return TaskCreationViewModel(
        authService,
        ref.read(imagePickerProvider),
        ref.read(taskServiceProvider),
        ref.read(
          postedTasksViewModelProvider.notifier,
        ), // Untuk refresh after post
      );
    });

class TaskCreationViewModel extends StateNotifier<Task> {
  final AuthService _authService;
  final ImagePicker _imagePicker;
  final TaskService _taskService;
  final TaskListViewModel _postedTasksNotifier;

  TaskCreationViewModel(
    this._authService,
    this._imagePicker,
    this._taskService,
    this._postedTasksNotifier,
  ) : super(
        Task.createNew(userId: '', taskName: '', deadline: DateTime.now()),
      ); // Initial dummy task

  void initializeNewTask() {
    state = Task.createNew(
      userId: _authService.getCurrentUserId(),
      taskName: '',
      deadline: DateTime.now().add(const Duration(hours: 1)),
    );
  }

  void updateTaskName(String name) {
    state = state.copyWith(taskName: name);
  }

  void updateDeadline(DateTime deadline) {
    state = state.copyWith(deadline: deadline);
  }

  Future<void> pickPhoto() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      ); // Atau .camera
      if (image != null) {
        state = state.copyWith(photoPath: image.path);
      }
    } catch (e) {
      print('Error picking image: $e'); // Handle error in UI
    }
  }

  void updateDifficulty(TaskDifficulty difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  void postTask() {
    if (state.taskName.isNotEmpty && state.deadline.isAfter(DateTime.now())) {
      _taskService.addTask(state);
      _postedTasksNotifier.refreshTasks(); // Refresh list setelah post
      // Reset state atau arahkan pengguna kembali ke halaman daftar
      initializeNewTask(); // Reset untuk task berikutnya
    } else {
      // Handle validation error
      print("Task name and deadline are required.");
    }
  }
}
