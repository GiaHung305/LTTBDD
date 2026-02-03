// lib/models/task_model.dart
class TaskModel {
  final String id;
  final String userId;
  final String title;
  final String description;
  final bool isCompleted;
  final String category;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    this.isCompleted = false,
    this.category = 'Homework',
    required this.createdAt,
  });

  TaskModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    bool? isCompleted,
    String? category,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'isCompleted': isCompleted ? 1 : 0,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      userId: map['userId'],
      title: map['title'],
      description: map['description'],
      isCompleted: map['isCompleted'] == 1,
      category: map['category'] ?? 'Homework',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}