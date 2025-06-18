import 'package:flutter/material.dart';
import 'package:jam/models/task.dart';
import 'package:jam/services/task_service.dart';

class EditTaskViewModel extends ChangeNotifier {
  final TaskService _taskService = TaskService();
  final formKey = GlobalKey<FormState>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  bool isSaving = false;

  void initialize(Task task) {
    titleController = TextEditingController(text: task.title);
    descriptionController = TextEditingController(text: task.description);
    selectedDate = task.deadline;
    selectedTime = TimeOfDay.fromDateTime(task.deadline);
  }

  Future<bool> submit(int taskId) async {
    if (!formKey.currentState!.validate()) return false;

    isSaving = true;
    notifyListeners();

    final DateTime finalDeadline = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime?.hour ?? 0,
      selectedTime?.minute ?? 0,
    );

    final success = await _taskService.updateTask(
      id: taskId,
      title: titleController.text,
      description: descriptionController.text,
      deadline: finalDeadline.toIso8601String(),
    );

    isSaving = false;
    notifyListeners();

    return success;
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setTime(TimeOfDay time) {
    selectedTime = time;
    notifyListeners();
  }
}
