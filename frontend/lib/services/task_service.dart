import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jam/models/answer.dart';
import 'package:jam/models/task.dart';
import 'package:jam/models/task_difficulty.dart';
import 'package:uuid/uuid.dart'; // Import Uuid

// Provider untuk TaskService
final taskServiceProvider = Provider((ref) => TaskService());

class TaskService {
  // Simulasi database in-memory
  final List<Task> _tasks = [];
  final List<Answer> _answers = [];

  // Mengambil semua tugas
  List<Task> getTasks() {
    return List.unmodifiable(_tasks);
  }

  // Menambahkan tugas baru
  void addTask(Task task) {
    _tasks.add(task);
  }

  // Memperbarui tugas
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
    }
  }

  // Menghapus tugas (opsional, jika ada fitur hapus)
  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
  }

  // Mengambil tugas berdasarkan ID
  Task? getTaskById(String taskId) {
    return _tasks.firstWhere((task) => task.id == taskId);
  }

  // Menambahkan jawaban untuk tugas
  void addAnswer(Answer answer) {
    _answers.add(answer);
  }

  // Mengambil jawaban berdasarkan Task ID
  List<Answer> getAnswersForTask(String taskId) {
    return _answers.where((answer) => answer.taskId == taskId).toList();
  }

  // Mendapatkan semua jawaban yang dibuat oleh user tertentu
  List<Answer> getAnswersByUserId(String userId) {
    return _answers.where((answer) => answer.userId == userId).toList();
  }

  // Menyetujui jawaban dan memberikan poin (simulasi)
  void approveAnswer(String answerId, int points) {
    final index = _answers.indexWhere((answer) => answer.id == answerId);
    if (index != -1) {
      _answers[index] = _answers[index].copyWith(
        isApproved: true,
        pointsEarned: points,
      );
    }
  }

  // Simulasi menambahkan beberapa tugas awal
  TaskService() {
    // Tugas contoh 1 (diposting oleh user_123)
    addTask(
      Task(
        id: const Uuid().v4(),
        userId: 'user_123',
        taskName: 'Desain Logo Aplikasi',
        deadline: DateTime.now().add(const Duration(days: 7)),
        photoPath: 'assets/images/sample_logo_design.png', // Contoh path
        difficulty: TaskDifficulty.hard,
        description:
            'Buat desain logo modern untuk aplikasi manajemen tugas. Sertakan elemen minimalis.',
      ),
    );
    // Tugas contoh 2 (diposting oleh orang lain)
    addTask(
      Task(
        id: const Uuid().v4(),
        userId: 'user_456',
        taskName: 'Buat Artikel Blog',
        deadline: DateTime.now().add(const Duration(days: 3)),
        photoPath: 'assets/images/sample_blog_post.png',
        difficulty: TaskDifficulty.easy,
        description:
            'Tulis artikel tentang 5 tips produktivitas menggunakan Pomodoro.',
      ),
    );
  }
}
