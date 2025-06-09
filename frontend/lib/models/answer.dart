import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

@immutable
class Answer {
  final String id;
  final String taskId; // ID tugas yang dijawab
  final String userId; // ID user yang menjawab
  final String photoPath; // Foto jawaban
  final String description; // Deskripsi jawaban
  final String? comment; // Komentar tambahan
  final DateTime submittedAt;
  final bool isApproved; // Apakah jawaban sudah disetujui
  final int? pointsEarned; // Poin yang didapat jika disetujui

  const Answer({
    required this.id,
    required this.taskId,
    required this.userId,
    required this.photoPath,
    required this.description,
    this.comment,
    required this.submittedAt,
    this.isApproved = false,
    this.pointsEarned,
  });

  Answer copyWith({
    String? id,
    String? taskId,
    String? userId,
    String? photoPath,
    String? description,
    String? comment,
    DateTime? submittedAt,
    bool? isApproved,
    int? pointsEarned,
  }) {
    return Answer(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      userId: userId ?? this.userId,
      photoPath: photoPath ?? this.photoPath,
      description: description ?? this.description,
      comment: comment ?? this.comment,
      submittedAt: submittedAt ?? this.submittedAt,
      isApproved: isApproved ?? this.isApproved,
      pointsEarned: pointsEarned ?? this.pointsEarned,
    );
  }

  factory Answer.createNew({
    required String taskId,
    required String userId,
    required String photoPath,
    required String description,
    String? comment,
  }) {
    return Answer(
      id: const Uuid().v4(),
      taskId: taskId,
      userId: userId,
      photoPath: photoPath,
      description: description,
      comment: comment,
      submittedAt: DateTime.now(),
    );
  }
}
