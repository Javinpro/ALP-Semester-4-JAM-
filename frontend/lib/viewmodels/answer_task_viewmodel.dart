import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jam/models/answer.dart';
import 'package:jam/models/task.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/services/task_service.dart';
import 'package:jam/viewmodels/common_providers.dart';

final answerTaskViewModelProvider = StateNotifierProvider.family
    .autoDispose<AnswerTaskViewModel, Answer?, String>((ref, taskId) {
      final authService = ref.watch(authServiceProvider);
      final taskService = ref.watch(taskServiceProvider);
      final imagePicker = ref.watch(imagePickerProvider);
      return AnswerTaskViewModel(taskId, authService, taskService, imagePicker);
    });

class AnswerTaskViewModel extends StateNotifier<Answer?> {
  final String _taskId;
  final AuthService _authService;
  final TaskService _taskService;
  final ImagePicker _imagePicker;

  AnswerTaskViewModel(
  this._taskId,
  this._authService,
  this._taskService,
  this._imagePicker,
) : super(null) {
  _initializeAnswer();
}

Future<void> _initializeAnswer() async {
  final userId = await _authService.getCurrentUserId();
  if (userId != null) {
    state = Answer.createNew(
      taskId: _taskId,
      userId: userId,
      photoPath: '',
      description: '',
    );
  }
}


  void updatePhotoPath(String path) {
    if (state != null) {
      state = state!.copyWith(photoPath: path);
    }
  }

  void updateDescription(String description) {
    if (state != null) {
      state = state!.copyWith(description: description);
    }
  }

  void updateComment(String comment) {
    if (state != null) {
      state = state!.copyWith(comment: comment);
    }
  }

  Future<void> pickAnswerPhoto() async {
    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );
      if (image != null) {
        updatePhotoPath(image.path);
      }
    } catch (e) {
      print('Error picking answer image: $e'); // Handle error in UI
    }
  }

  Future<bool> submitAnswer() async {
    if (state != null &&
        state!.photoPath.isNotEmpty &&
        state!.description.isNotEmpty) {
      _taskService.addAnswer(state!);
      // Mark the task as "completed" by this user, or handle points later
      final task = _taskService.getTaskById(_taskId);
      if (task != null) {
        _taskService.updateTask(
          task.copyWith(assignedToUserId: await _authService.getCurrentUserId()),
        );
        // Note: The task is still visible in "Doing" until approved by the task owner.
      }
      return true; // Success
    }
    return false; // Validation failed
  }
}
