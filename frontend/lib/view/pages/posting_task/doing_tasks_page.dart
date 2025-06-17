import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/view/widgets/task_card.dart';
import 'package:jam/viewmodels/task_list_viewmodel.dart';

class DoingTasksPage extends ConsumerWidget {
  const DoingTasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doingTasks = ref.watch(doingTasksViewModelProvider);
    final currentUserId = ref.read(authServiceProvider).getCurrentUserId();

    // Filter tugas yang sedang dikerjakan oleh user saat ini
    final tasksDoingByMe =
        doingTasks
            .where((task) => task.assignedToUserId == currentUserId)
            .toList();

    return Scaffold(
      backgroundColor: backgroundColor,
      body:
          tasksDoingByMe.isEmpty
              ? Center(
                child: Text(
                  'No tasks currently being done.\nGo to "Posted" and pick one!',
                  style: body1.copyWith(color: Colors.black54),
                  textAlign: TextAlign.center,
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: tasksDoingByMe.length,
                itemBuilder: (context, index) {
                  final task = tasksDoingByMe[index];
                  return TaskCard(
                    task: task,
                    isYourPost: false,
                    isDoingTask: true,
                  ); // isDoingTask menandakan ini di halaman doing
                },
              ),
    );
  }
}

// Re-using TaskCard for consistency, just adding isDoingTask param
// Update TaskCard widget accordingly
