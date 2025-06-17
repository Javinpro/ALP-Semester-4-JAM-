// lib/models/task.dart
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:jam/models/task_difficulty.dart';

@immutable
class Task {
  final String id;
  final String userId; // ID user yang memposting tugas
  final String taskName;
  final DateTime deadline;
  final String? photoPath;
  final TaskDifficulty? difficulty;
  final String? description;
  final String? assignedToUserId; // ID user yang sedang mengerjakan tugas ini

  const Task({
    required this.id,
    required this.userId,
    required this.taskName,
    required this.deadline,
    this.photoPath,
    this.difficulty,
    this.description,
    this.assignedToUserId,
  });

  Task copyWith({
    String? id,
    String? userId,
    String? taskName,
    DateTime? deadline,
    String? photoPath,
    TaskDifficulty? difficulty,
    String? description,
    String? assignedToUserId, // Perhatikan: ini bisa null
  }) {
    return Task(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      taskName: taskName ?? this.taskName,
      deadline: deadline ?? this.deadline,
      photoPath: photoPath ?? this.photoPath,
      difficulty: difficulty ?? this.difficulty,
      description: description ?? this.description,
      assignedToUserId: assignedToUserId, // Penting: ini bisa disetel null
    );
  }

  // Factory constructor untuk membuat task baru dengan ID unik
  factory Task.createNew({
    required String userId, // User yang memposting
    required String taskName,
    required DateTime deadline,
    String? photoPath,
    TaskDifficulty? difficulty,
    String? description,
    String? assignedToUserId, // Tambahkan ini sebagai parameter opsional
  }) {
    return Task(
      id: const Uuid().v4(),
      userId: userId,
      taskName: taskName,
      deadline: deadline,
      photoPath: photoPath,
      difficulty: difficulty,
      description: description,
      // Jika assignedToUserId tidak diberikan, secara default sama dengan userId yang memposting
      assignedToUserId: assignedToUserId ?? userId,
    );
  }
}
