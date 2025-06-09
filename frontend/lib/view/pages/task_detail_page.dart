import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jam/view/widgets/colors.dart';
import 'package:jam/view/widgets/text_template.dart';
import 'package:jam/models/task_difficulty.dart';
import 'package:jam/view/pages/answer_task_page.dart';
import 'package:jam/viewmodels/task_detail_viewmodel.dart';
import 'package:jam/viewmodels/task_list_viewmodel.dart'; // Untuk assignTaskToCurrentUser

class TaskDetailPage extends ConsumerWidget {
  final String taskId;
  final bool
  isYourPost; // Untuk menentukan apakah ini tugas milik user saat ini

  const TaskDetailPage({
    super.key,
    required this.taskId,
    required this.isYourPost,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskDetailViewModelProvider(taskId));
    final postedTasksNotifier = ref.read(
      postedTasksViewModelProvider.notifier,
    ); // Untuk assign task

    if (task == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Task Detail')),
        body: const Center(child: Text('Task not found.')),
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(task.taskName, style: headerblack4),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Task Photo
            if (task.photoPath != null && task.photoPath!.isNotEmpty)
              Center(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: FileImage(File(task.photoPath!)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            else
              Center(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
                  ),
                ),
              ),
            const SizedBox(height: 20),

            Text('Task Name:', style: headerblack3),
            Text(task.taskName, style: body1),
            const SizedBox(height: 15),

            Text('Deadline:', style: headerblack3),
            Text(
              DateFormat('dd MMM yyyy HH:mm').format(task.deadline),
              style: body1,
            ),
            const SizedBox(height: 15),

            Text('Difficulty:', style: headerblack3),
            Text(
              task.difficulty?.displayName ?? 'N/A',
              style: body1.copyWith(
                color:
                    task.difficulty == TaskDifficulty.hard
                        ? redColor
                        : Colors.green,
              ),
            ),
            const SizedBox(height: 15),

            Text('Description:', style: headerblack3),
            Text(task.description ?? 'No description provided.', style: body1),
            const SizedBox(height: 30),

            if (!isYourPost) // Hanya tampilkan tombol ini jika bukan tugas Anda
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
                    // Assign task to current user
                    postedTasksNotifier.assignTaskToCurrentUser(task.id);
                    Navigator.pushReplacement(
                      // Ganti halaman, agar tidak bisa kembali ke detail ini
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnswerTaskPage(taskId: task.id),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Task moved to "Doing" list!'),
                      ),
                    );
                  },
                  child: Text('Do This Task', style: headerblack),
                ),
              ),
            if (isYourPost)
              Center(
                child: Text(
                  'This is your posted task.',
                  style: body2.copyWith(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
