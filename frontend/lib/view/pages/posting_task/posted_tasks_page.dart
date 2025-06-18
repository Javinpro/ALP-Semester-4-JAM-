// // lib/view/pages/posting_task/posted_tasks_page.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:jam/view/pages/posting_task/others_posts.dart';
// import 'package:jam/view/pages/posting_task/selection_task_page.dart';
// import 'package:jam/view/pages/posting_task/your_posts.dart'; // Ini adalah halaman 'All Your Posts'
// import 'package:jam/view/utils/colors.dart';
// import 'package:jam/services/auth_service.dart';
// import 'package:jam/view/utils/text_template.dart';
// import 'package:jam/view/widgets/task_card.dart'; // TaskCard untuk menampilkan item
// import 'package:jam/viewmodels/task_list_post_viewmodel.dart';

// class PostedTasksPage extends ConsumerWidget {
//   const PostedTasksPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Watch provider untuk mendapatkan daftar tugas yang terbaru
//     final allTasks = ref.watch(taskListViewModelProvider);
//     final currentUserId = ref.read(authServiceProvider).getCurrentUserId();

//     // Pisahkan Your Post dan Others Post berdasarkan state terbaru dari ViewModel
//     final yourPosts =
//         allTasks.where((task) => task.userId == currentUserId).toList();
//     // Mengambil 3 tugas pertama untuk carousel (atau kurang jika tidak sampai 3)
//     final limitedYourPosts = yourPosts.take(3).toList();

//     final othersPosts =
//         allTasks
//             .where(
//               (task) =>
//                   task.userId != currentUserId && task.assignedToUserId == null,
//             )
//             .toList();
//     // Mengambil 3 tugas pertama untuk carousel (atau kurang jika tidak sampai 3)
//     final limitedOthersPosts = othersPosts.take(3).toList();

//     return Scaffold(
//       backgroundColor: backgroundColor,
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Header
//                 Row(
//                   children: [
//                     Icon(Icons.track_changes, color: secondaryColor, size: 25),
//                     const SizedBox(width: 5),
//                     sizedbox9,
//                     Text('Beginner', style: headerblack),
//                   ],
//                 ),
//                 // Point Section (Simulasi)
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   decoration: BoxDecoration(
//                     color: primaryColor,
//                     border: Border.all(color: secondaryColor, width: 2),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Row(
//                     children: [
//                       Text('50%', style: headerblack2),
//                       const Spacer(),
//                     ],
//                   ),
//                 ),
//                 sizedbox11,

//                 // Your Post Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Your Posts', style: headerblack3),
//                     TextButton(
//                       onPressed: () {
//                         // Navigasi ke halaman YourPosts lengkap
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) =>
//                                     const YourPosts(), // Mengarah ke YourPosts.dart
//                           ),
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: primaryColor,
//                           borderRadius: BorderRadius.circular(5.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.3),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0,
//                           vertical: 4.0,
//                         ),
//                         child: Text('See More', style: headerblack2),
//                       ),
//                     ),
//                   ],
//                 ),
//                 sizedbox1,
//                 // Carousel untuk Your Posts
//                 SizedBox(
//                   // Bungkus dengan SizedBox agar punya tinggi terbatas
//                   height: 200, // Sesuaikan tinggi sesuai kebutuhan card Anda
//                   child:
//                       limitedYourPosts.isEmpty
//                           ? Center(
//                             child: const Text(
//                               'No tasks posted yet.',
//                               style: body2,
//                             ),
//                           )
//                           : ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: limitedYourPosts.length,
//                             itemBuilder: (context, index) {
//                               final task = limitedYourPosts[index];
//                               return Container(
//                                 width:
//                                     MediaQuery.of(context).size.width *
//                                     0.8, // Lebar setiap card
//                                 margin: const EdgeInsets.symmetric(
//                                   horizontal: 8.0,
//                                 ),
//                                 child: TaskCard(task: task, isYourPost: true),
//                               );
//                             },
//                           ),
//                 ),
//                 sizedbox11,

//                 // Others Post Section
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Others Posts', style: headerblack3),
//                     TextButton(
//                       onPressed: () {
//                         // Navigasi ke halaman OthersTasks lengkap
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (context) =>
//                                     const OthersTasks(), // Mengarah ke OthersTasks.dart
//                           ),
//                         );
//                       },
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: primaryColor,
//                           borderRadius: BorderRadius.circular(5.0),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.3),
//                               spreadRadius: 1,
//                               blurRadius: 5,
//                               offset: const Offset(0, 2),
//                             ),
//                           ],
//                         ),
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8.0,
//                           vertical: 4.0,
//                         ),
//                         child: Text('See More', style: headerblack2),
//                       ),
//                     ),
//                   ],
//                 ),
//                 sizedbox1,
//                 // Carousel untuk Others Posts
//                 SizedBox(
//                   // Bungkus dengan SizedBox agar punya tinggi terbatas
//                   height: 200, // Sesuaikan tinggi sesuai kebutuhan card Anda
//                   child:
//                       limitedOthersPosts.isEmpty
//                           ? Center(
//                             child: const Text(
//                               'No other tasks posted yet.',
//                               style: body2,
//                             ),
//                           )
//                           : ListView.builder(
//                             scrollDirection: Axis.horizontal,
//                             itemCount: limitedOthersPosts.length,
//                             itemBuilder: (context, index) {
//                               final task = limitedOthersPosts[index];
//                               return Container(
//                                 width:
//                                     MediaQuery.of(context).size.width *
//                                     0.8, // Lebar setiap card
//                                 margin: const EdgeInsets.symmetric(
//                                   horizontal: 8.0,
//                                 ),
//                                 child: TaskCard(task: task, isYourPost: false),
//                               );
//                             },
//                           ),
//                 ),
//                 const SizedBox(height: 150),
//               ],
//             ),
//           ),
//           Positioned(
//             bottom: 110,
//             left: 85,
//             right: 85,
//             child: ElevatedButton(
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const SelectTaskPage(),
//                   ),
//                 );
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: primaryColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 14,
//                   horizontal: 6,
//                 ),
//                 elevation: 5,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [Text('Post Your Task', style: headerblack)],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
