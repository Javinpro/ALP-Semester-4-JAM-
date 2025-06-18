// import 'package:flutter/material.dart';
// import 'package:jam/models/task.dart';
// import 'package:jam/view/utils/colors.dart';
// import 'package:jam/view/utils/text_template.dart';

// class TaskCard extends StatelessWidget {
//   final Task task;
//   final int currentUserId;
//   final bool isYourPost;

//   const TaskCard({
//     Key? key,
//     required this.task,
//     required this.currentUserId,
//     this.isYourPost = false,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//       elevation: 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       color: isYourPost ? primaryColor.withOpacity(0.5) : Colors.white,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               task.taskName,
//               style: headerblack3,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             sizedbox1,
//             Text(
//               task.description ?? 'Tidak ada deskripsi.',
//               style: body2,
//               maxLines: 3,
//               overflow: TextOverflow.ellipsis,
//             ),
//             sizedbox1,
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 if (task.difficulty != null)
//                   Chip(
//                     label: Text(task.difficulty!),
//                     backgroundColor: secondaryColor.withOpacity(0.2),
//                   ),
//                 Text(
//                   'Deadline: ${task.deadline.toLocal().toString().split(' ')[0]}',
//                   style: body3.copyWith(color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//             if (task.assignedToUserId != null)
//               Padding(
//                 padding: const EdgeInsets.only(top: 8.0),
//                 child: Text(
//                   'Ditugaskan ke: ${task.assignedToUserId == currentUserId ? "Anda" : "Orang lain"}',
//                   style: body3.copyWith(fontStyle: FontStyle.italic),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
