import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/models/task_difficulty.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/models/task.dart';

class TaskCard extends ConsumerWidget {
  final Task task;
  final bool isYourPost;
  final bool isDoingTask;

  const TaskCard({
    Key? key,
    required this.task,
    required this.isYourPost,
    this.isDoingTask = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      child: InkWell(
        onTap: () {
          // TODO: Aktifkan navigasi berdasarkan halaman
          // if (isDoingTask) {
          //   Navigator.push(context, MaterialPageRoute(
          //     builder: (context) => AnswerTaskPage(taskId: task.id),
          //   ));
          // } else {
          //   Navigator.push(context, MaterialPageRoute(
          //     builder: (context) => TaskDetailPage(
          //       taskId: task.id,
          //       isYourPost: isYourPost,
          //     ),
          //   ));
          // }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(task.title, style: headerblack3),
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
                  'Difficulty: ${task.difficulty}',
                  style: body2.copyWith(
                    color: task.difficulty == 'susah' ? redColor : Colors.green,
                  ),
                ),
              ],
              if (isDoingTask) ...[
                const SizedBox(height: 8),
                Text(
                  'Status: Sedang dikerjakan',
                  style: body2.copyWith(color: primaryColor),
                ),
              ],
              if (task.description != null && task.description!.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  task.description!,
                  style: body2,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
