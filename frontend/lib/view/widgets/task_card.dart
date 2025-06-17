import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Tambahkan intl di pubspec.yaml: intl: ^0.19.0
import 'package:jam/view/utils/colors.dart';
import 'package:jam/models/task_difficulty.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/models/task.dart';

class TaskCard extends ConsumerWidget {
  final Task task;
  final bool isYourPost;
  final bool
  isDoingTask; // Indikator apakah card ini ditampilkan di halaman 'Doing'

  const TaskCard({
    super.key,
    required this.task,
    required this.isYourPost,
    this.isDoingTask = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          if (isDoingTask) {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => AnswerTaskPage(taskId: task.id),
            //   ),
            // );
          } else {
            // Navigator.push(
            //   // context,
            //   // MaterialPageRoute(
            //   //   builder:
            //   //       (context) =>
            //   //           TaskDetailPage(taskId: task.id, isYourPost: isYourPost),
            //   // ),
            // );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.taskName, style: headerblack3),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  const SizedBox(width: 5),
                  Text(
                    'Deadline: ${DateFormat('dd MMM yyyy HH:mm').format(task.deadline)}',
                    style: body2.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              if (task.difficulty != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Difficulty: ${task.difficulty!.displayName}',
                  style: body2.copyWith(
                    color:
                        task.difficulty == TaskDifficulty.hard
                            ? redColor
                            : Colors.green,
                  ),
                ),
              ],
              if (isDoingTask && task.assignedToUserId != null) ...[
                const SizedBox(height: 8),
                Text(
                  'Status: Doing by you',
                  style: body2.copyWith(color: primaryColor),
                ),
              ],
              // Anda bisa menambahkan foto preview di sini jika diinginkan
              // if (task.photoPath != null && task.photoPath!.isNotEmpty) ...[
              //   const SizedBox(height: 10),
              //   Image.file(File(task.photoPath!), height: 100, width: 100, fit: BoxFit.cover),
              // ],
            ],
          ),
        ),
      ),
    );
  }
}
