// lib/view/pages/posting_task/others_tasks.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/utils/colors.dart';
import 'package:jam/view/utils/text_template.dart';
import 'package:jam/view/widgets/task_card.dart'; // Re-use TaskCard
import 'package:jam/viewmodels/task_list_post_viewmodel.dart';
import 'package:jam/services/auth_service.dart';

// Enum TaskListType tidak lagi diperlukan di file ini karena sudah spesifik
// enum TaskListType { yourPosts, othersPosts }

class YourPosts extends ConsumerWidget {
  // Tetap gunakan nama kelas ini sesuai permintaan
  // Hapus parameter listType karena halaman ini hanya untuk Others Posts
  const YourPosts({super.key});

  // Fungsi untuk mendapatkan judul halaman yang spesifik
  String _getPageTitle() {
    return 'Your Post';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allTasks = ref.watch(taskListViewModelProvider);
    final currentUserId =
        ref.read(authServiceProvider).getCurrentUserId(); // Asumsi ini sinkron

    // Logika filtering langsung untuk Others Posts
    final tasksToShow =
        allTasks
            .where(
              (task) =>
                  task.userId != currentUserId && // Tugas dari user lain
                  task.assignedToUserId == null, // Dan belum di-assign
            )
            .toList();
    const bool isYourPostCard = false; // Selalu false untuk Others Tasks

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        scrolledUnderElevation: 0,
        title: Text(_getPageTitle(), style: headerblack3),
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor.withOpacity(0.3),
                  spreadRadius: 0,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: secondaryColor),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body:
          tasksToShow.isEmpty
              ? Center(
                child: Text('Tidak ada tugas di daftar ini.', style: body2),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: tasksToShow.length,
                itemBuilder: (context, index) {
                  final task = tasksToShow[index];
                  return TaskCard(task: task, isYourPost: isYourPostCard);
                },
              ),
    );
  }
}
