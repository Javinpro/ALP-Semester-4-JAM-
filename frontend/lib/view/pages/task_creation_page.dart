import 'dart:io'; // Untuk File
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/models/task_difficulty.dart';
import 'package:jam/viewmodels/task_creation_viewmodel.dart';

class TaskCreationPage extends ConsumerStatefulWidget {
  const TaskCreationPage({super.key});

  @override
  ConsumerState<TaskCreationPage> createState() => _TaskCreationPageState();
}

class _TaskCreationPageState extends ConsumerState<TaskCreationPage> {
  final _taskNameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(taskCreationViewModelProvider.notifier).initializeNewTask();
    });
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(
    BuildContext context,
    TaskCreationViewModel notifier,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: notifier.state.deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      notifier.updateDeadline(
        DateTime(
          picked.year,
          picked.month,
          picked.day,
          notifier.state.deadline.hour,
          notifier.state.deadline.minute,
        ),
      );
    }
  }

  Future<void> _selectTime(
    BuildContext context,
    TaskCreationViewModel notifier,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(notifier.state.deadline),
    );
    if (picked != null) {
      notifier.updateDeadline(
        DateTime(
          notifier.state.deadline.year,
          notifier.state.deadline.month,
          notifier.state.deadline.day,
          picked.hour,
          picked.minute,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final taskState = ref.watch(taskCreationViewModelProvider);
    final notifier = ref.read(taskCreationViewModelProvider.notifier);

    _taskNameController.text = taskState.taskName;
    _descriptionController.text = taskState.description ?? '';

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Create New Task', style: headerblack4),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task Name', style: headerblack3),
            const SizedBox(height: 8),
            TextField(
              controller: _taskNameController,
              decoration: const InputDecoration(
                hintText: 'Enter task name',
                border: OutlineInputBorder(),
              ),
              onChanged: notifier.updateTaskName,
            ),
            const SizedBox(height: 20),

            Text('Deadline', style: headerblack3),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectDate(context, notifier),
                    child: Text(
                      DateFormat('dd MMM yyyy').format(taskState.deadline),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _selectTime(context, notifier),
                    child: Text(DateFormat('HH:mm').format(taskState.deadline)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Text('Task Photo (Optional)', style: headerblack3),
            const SizedBox(height: 8),
            Center(
              child: InkWell(
                onTap: notifier.pickPhoto,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey),
                  ),
                  child:
                      taskState.photoPath != null &&
                              taskState.photoPath!.isNotEmpty
                          ? Image.file(
                            File(taskState.photoPath!),
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                          )
                          : const Icon(
                            Icons.camera_alt,
                            size: 50,
                            color: Colors.grey,
                          ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            Text('Task Difficulty', style: headerblack3),
            const SizedBox(height: 8),
            Row(
              children:
                  TaskDifficulty.values.map((difficulty) {
                    return Expanded(
                      child: RadioListTile<TaskDifficulty>(
                        title: Text(difficulty.displayName),
                        value: difficulty,
                        groupValue: taskState.difficulty,
                        onChanged: (TaskDifficulty? value) {
                          if (value != null) {
                            notifier.updateDifficulty(value);
                          }
                        },
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),

            Text('Task Description', style: headerblack3),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Enter task description',
                border: OutlineInputBorder(),
              ),
              onChanged: notifier.updateDescription,
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 8,
                ),
                onPressed: () {
                  notifier.postTask();
                  Navigator.pop(
                    context,
                  ); // Kembali ke halaman sebelumnya setelah posting
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Task Posted Successfully!')),
                  );
                },
                child: Text('Post Task', style: headerblack),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
