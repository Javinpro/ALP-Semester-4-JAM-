import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/view/widgets/colors.dart';
import 'package:jam/services/auth_service.dart';
import 'package:jam/view/widgets/text_template.dart';
import 'package:jam/view/pages/task_creation_page.dart';
import 'package:jam/view/widgets/task_card.dart';
import 'package:jam/viewmodels/task_list_viewmodel.dart';

class PostedTasksPage extends ConsumerWidget {
  const PostedTasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postedTasks = ref.watch(postedTasksViewModelProvider);
    final currentUserId = ref.read(authServiceProvider).getCurrentUserId();

    // Pisahkan Your Post dan Others Post
    final yourPosts =
        postedTasks.where((task) => task.userId == currentUserId).toList();
    final othersPosts =
        postedTasks
            .where((task) => task.userId != currentUserId)
            .toList(); // Ini mungkin kosong, akan diisi di TaskService.

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Point Section (Simulasi)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 30),
                  const SizedBox(width: 10),
                  Text(
                    'Your Points: 150',
                    style: headerblack2.copyWith(color: Colors.white),
                  ), // Contoh poin
                  const Spacer(),
                  // Anda bisa menambahkan button untuk melihat history poin di sini
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Your Post Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Your Posts', style: headerblack3),
                TextButton(
                  onPressed: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => YourAllPostsPage())); // Halaman untuk melihat semua postingan Anda
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('See More Your Posts coming soon!'),
                      ),
                    );
                  },
                  child: Text(
                    'See More',
                    style: body1.copyWith(color: primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            yourPosts.isEmpty
                ? const Text('No tasks posted yet.', style: body2)
                : Column(
                  children:
                      yourPosts
                          .map((task) => TaskCard(task: task, isYourPost: true))
                          .toList(),
                ),
            const SizedBox(height: 30),

            // Others Post Section
            Text('Others Posts', style: headerblack3),
            const SizedBox(height: 10),
            // Seharusnya ini difilter di TaskListViewModel untuk hanya menampilkan tugas yang belum di-assign atau belum milik user_123.
            // Untuk demo, kita ambil semua tugas kecuali milik current user.
            othersPosts.isEmpty
                ? const Text('No other tasks posted yet.', style: body2)
                : Column(
                  children:
                      othersPosts
                          .map(
                            (task) => TaskCard(task: task, isYourPost: false),
                          )
                          .toList(),
                ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TaskCreationPage()),
          );
        },
        label: const Text('Post Your Task', style: headerwhite),
        icon: const Icon(Icons.add, color: Colors.white),
        backgroundColor: secondaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
