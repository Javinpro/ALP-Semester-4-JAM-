// // lib/viewmodels/task_list_viewmodel.dart
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:jam/models/task.dart';
// import 'package:jam/view/pages/posting_task/dummy_task_card.dart'; // Menggunakan dummy data

// class TaskListViewModel extends StateNotifier<List<Task>> {
//   TaskListViewModel() : super([]);

//   // Metode untuk memuat semua tugas dari repository/service
//   void loadAllTasks() {
//     state = allDummyTasks; // Memuat semua tugas dummy
//   }

//   // Metode untuk "mengambil" atau meng-assign tugas ke current user
//   void assignTaskToCurrentUser(String taskId, String currentUserId) {
//     state = [
//       for (final task in state)
//         if (task.id == taskId)
//           // Membuat salinan tugas dengan assignedToUserId yang diperbarui
//           // dan userId diubah menjadi currentUserId (karena ini akan muncul di "Your Posts")
//           task.copyWith(assignedToUserId: currentUserId, userId: currentUserId)
//         else
//           task,
//     ];
//   }

//   // Metode untuk menambahkan tugas baru (simulasi, jika ada fitur post manual)
//   void addTask(Task newTask) {
//     state = [...state, newTask];
//   }

//   // Metode untuk memperbarui tugas (simulasi)
//   void updateTask(Task updatedTask) {
//     state = [
//       for (final task in state)
//         if (task.id == updatedTask.id) updatedTask else task,
//     ];
//   }

//   // Metode untuk mendapatkan "Your Posted Tasks" dari state
//   List<Task> getYourPostedTasks(String userId) {
//     return state.where((task) => task.userId == userId).toList();
//   }

//   // Metode untuk mendapatkan "Others Posted Tasks" dari state
//   List<Task> getOthersPostedTasks(String userId) {
//     return state
//         .where((task) => task.userId != userId && task.assignedToUserId == null)
//         .toList();
//   }
// }

// // Provider untuk TaskListViewModel
// final taskListViewModelProvider =
//     StateNotifierProvider<TaskListViewModel, List<Task>>((ref) {
//       final viewModel = TaskListViewModel();
//       viewModel.loadAllTasks(); // Memuat data saat provider dibuat
//       return viewModel;
//     });
