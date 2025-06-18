// // lib/view/pages/posting_task/select_task_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart'; // Tetap gunakan Riverpod jika nanti diperlukan
// import 'package:jam/models/task.dart'; // Import model Task
// import 'package:jam/view/pages/posting_task/dummy_task_card.dart';
// import 'package:jam/view/utils/colors.dart'; // Import colors
// import 'package:jam/view/utils/text_template.dart'; // Import text styles and sized boxes
// import 'package:jam/view/pages/posting_task/task_detail_page.dart'; // Import TaskDetailPage

// class SelectTaskPage extends ConsumerStatefulWidget {
//   // Ubah menjadi ConsumerStatefulWidget
//   const SelectTaskPage({super.key});

//   @override
//   ConsumerState<SelectTaskPage> createState() => _SelectTaskPageState();
// }

// class _SelectTaskPageState extends ConsumerState<SelectTaskPage> {
//   String? _selectedTaskId; // Untuk melacak ID tugas yang dipilih

//   List<Task> _availableTasks = []; // Daftar tugas yang akan ditampilkan

//   @override
//   void initState() {
//     super.initState();
//     // Memuat tugas yang belum di-assign dari dummy data
//     _availableTasks =
//         getUnassignedTasks(); // Menggunakan fungsi helper dari dummy_tasks.dart
//   }

//   void _toggleTaskSelection(String taskId) {
//     setState(() {
//       if (_selectedTaskId == taskId) {
//         _selectedTaskId = null; // Batalkan pilihan jika sudah dipilih
//       } else {
//         _selectedTaskId = taskId; // Pilih tugas baru
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       appBar: AppBar(
//         backgroundColor: backgroundColor,
//         scrolledUnderElevation: 0,
//         title: const Text('Pilih Tugas', style: headerblack3), // Ubah judul
//         leading: Padding(
//           padding: const EdgeInsets.all(6.0),
//           child: Container(
//             decoration: BoxDecoration(
//               color: primaryColor,
//               borderRadius: BorderRadius.circular(10.0),
//               boxShadow: [
//                 BoxShadow(
//                   color: secondaryColor.withOpacity(0.3),
//                   spreadRadius: 0,
//                   blurRadius: 6,
//                   offset: const Offset(0, 3),
//                 ),
//               ],
//             ),
//             child: IconButton(
//               icon: const Icon(Icons.arrow_back, color: secondaryColor),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ),
//       ),
//       body:
//           _availableTasks.isEmpty
//               ? Center(
//                 child: Text(
//                   'Tidak ada tugas yang tersedia untuk dipilih.',
//                   style: body2,
//                 ),
//               )
//               : ListView.separated(
//                 padding: const EdgeInsets.all(16.0),
//                 itemCount: _availableTasks.length,
//                 itemBuilder: (context, index) {
//                   final task = _availableTasks[index];
//                   final bool isSelected = _selectedTaskId == task.id;

//                   return Card(
//                     color:
//                         isSelected
//                             ? secondaryColor.withOpacity(0.3)
//                             : primaryColor, // Warna kartu berdasarkan pilihan
//                     elevation: 4.0,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                       side: BorderSide(
//                         color:
//                             isSelected
//                                 ? secondaryColor
//                                 : Colors
//                                     .transparent, // Border untuk yang terpilih
//                         width: 2,
//                       ),
//                     ),
//                     child: InkWell(
//                       // Menggunakan InkWell agar card bisa ditekan
//                       onTap: () => _toggleTaskSelection(task.id),
//                       borderRadius: BorderRadius.circular(10.0),
//                       child: Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     task.taskName,
//                                     style: headerblack3,
//                                   ), // Nama task
//                                   sizedbox5, // Spasi kecil
//                                   Text(
//                                     'Deadline: ${task.deadline.day}/${task.deadline.month}/${task.deadline.year} - ${task.deadline.hour.toString().padLeft(2, '0')}:${task.deadline.minute.toString().padLeft(2, '0')}',
//                                     style: body2.copyWith(
//                                       color: Colors.grey[700],
//                                     ), // Deadline
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Icon(
//                               isSelected
//                                   ? Icons.check_circle_rounded
//                                   : Icons.radio_button_off_rounded,
//                               color: isSelected ? secondaryColor : Colors.grey,
//                               size: 28,
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder:
//                     (context, index) => sizedbox1, // Pemisah antar card
//               ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//           if (_selectedTaskId == null) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(
//                 content: Text('Pilih salah satu tugas terlebih dahulu.'),
//               ),
//             );
//           } else {
//             // Cari tugas yang dipilih dari _availableTasks
//             final selectedTask = _availableTasks.firstWhere(
//               (task) => task.id == _selectedTaskId,
//             );

//             // Navigasi ke TaskDetailPage dengan membawa objek tugas
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => TaskDetailPage(task: selectedTask),
//               ),
//             );
//           }
//         },
//         label: const Text('Lihat Detail Tugas', style: headerwhite),
//         icon: const Icon(Icons.arrow_forward, color: Colors.white),
//         backgroundColor: secondaryColor,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
