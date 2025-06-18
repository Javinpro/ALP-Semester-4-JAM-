// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:jam/models/task.dart';
// import 'package:jam/models/task_difficulty.dart';
// import 'package:jam/services/auth_service.dart';
// import 'package:jam/services/task_service.dart';
// import 'package:jam/viewmodels/common_providers.dart';
// import 'package:jam/viewmodels/task_list_viewmodel.dart'; // Untuk refresh task list

// final taskCreationViewModelProvider =
//     StateNotifierProvider.autoDispose<TaskCreationViewModel, Task>((ref) {
//       final authService = ref.watch(authServiceProvider);
//       return TaskCreationViewModel(
//         authService,
//         ref.read(imagePickerProvider),
//         ref.read(taskServiceProvider),
//         ref.read(
//           postedTasksViewModelProvider.notifier,
//         ), // Untuk refresh after post
//       );
//     });

// class TaskCreationViewModel extends StateNotifier<Task> {
//   final AuthService _authService;
//   final ImagePicker _imagePicker;
//   final TaskService _taskService;
//   final TaskListViewModel _postedTasksNotifier;

//   TaskCreationViewModel(
//     this._authService,
//     this._imagePicker,
//     this._taskService,
//     this._postedTasksNotifier,
//   ) : super(Task.createNew(userId: '', taskName: '', deadline: DateTime.now()));

//   Future<void> initializeNewTask() async {
//     final userId = await _authService.getCurrentUserId();
//     if (userId != null) {
//       state = Task.createNew(
//         userId: userId,
//         taskName: '',
//         deadline: DateTime.now().add(const Duration(hours: 1)),
//       );
//     } else {
//       print('Error: userId null saat inisialisasi task');
//     }
//   }

//   void updateTaskName(String name) {
//     state = state.copyWith(taskName: name);
//   }

//   void updateDeadline(DateTime deadline) {
//     state = state.copyWith(deadline: deadline);
//   }

//   Future<void> pickPhoto() async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: ImageSource.gallery,
//       );
//       if (image != null) {
//         state = state.copyWith(photoPath: image.path);
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }

//   void updateDifficulty(TaskDifficulty difficulty) {
//     state = state.copyWith(difficulty: difficulty);
//   }

//   void updateDescription(String description) {
//     state = state.copyWith(description: description);
//   }

//   Future<void> postTask() async {
//     if (state.taskName.isNotEmpty && state.deadline.isAfter(DateTime.now())) {
//       _taskService.addTask(state);
//       _postedTasksNotifier.refreshTasks();
//       await initializeNewTask();
//     } else {
//       print("Task name and deadline are required.");
//     }
//   }
// }


