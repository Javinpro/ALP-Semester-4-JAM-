class Task {
  final int id;
  final String title;
  final String? description;
  final String? difficulty;
  final DateTime deadline;
  final bool isCompleted;
  final int userId;
  final bool inTodolist;

  Task({
    required this.id,
    required this.title,
    this.description,
    this.difficulty,
    required this.deadline,
    required this.isCompleted,
    required this.userId,
    required this.inTodolist,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      difficulty: json['difficulty'],
      deadline: DateTime.parse(json['deadline']),
      userId: json['user'], // pastikan ini sesuai response Django
      inTodolist: json['in_todolist'] ?? false,
      isCompleted: json['is_completed'] ?? false,
    );
  }
}
