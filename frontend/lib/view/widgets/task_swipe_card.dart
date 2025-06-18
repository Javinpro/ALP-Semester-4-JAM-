import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:jam/models/task.dart';
import 'package:jam/services/task_service.dart';
import 'package:jam/view/pages/edit_task_page.dart';

class TaskSwipeCard extends StatelessWidget {
  final Task task;
  final VoidCallback onUpdated;

  const TaskSwipeCard({
    Key? key,
    required this.task,
    required this.onUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TaskService _taskService = TaskService();

    return Slidable(
      key: ValueKey(task.id),
      endActionPane: ActionPane(
        motion: const DrawerMotion(),
        extentRatio: 0.75,
        children: [
          // ✅ EDIT
          SlidableAction(
            onPressed: (_) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EditTaskPage(task: task, onUpdated: onUpdated),
                ),
              );
              onUpdated();
            },
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            borderRadius: BorderRadius.circular(12),
          ),

          // ✅ DELETE
          SlidableAction(
            onPressed: (_) async {
              final success = await _taskService.deleteTask(task.id);
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Tugas berhasil dihapus")),
                );
                onUpdated();
                // Bisa trigger reload dengan Provider, setState, atau context.refresh()
              }
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(12),
          ),

          // ✅ ADD TO TODO
          SlidableAction(
            onPressed: (_) async {
              final success = await _taskService.addToTodolist(task.id);
              if (success && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Ditambahkan ke To Do List")),
                );
                onUpdated();
              }
            },
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            icon: Icons.playlist_add_check_rounded,
            borderRadius: BorderRadius.circular(12),
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        height: 110,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(task.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        DateFormat('dd - MM - yyyy').format(task.deadline),
                        style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const Text('|'),
                      const SizedBox(width: 10),
                      Text(
                        DateFormat('HH.mm').format(task.deadline),
                        style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    task.description ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
