class Task {
  final String id;
  final String title;
  bool isCompleted;
  final DateTime createdAt;
  final DateTime? deadline;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt, 
    this.deadline,
  });

Map<String, dynamic> toMap() {
  return {
    'id': id,
    'title': title,
    'isCompleted': isCompleted ? 1 : 0,
    'createdAt': createdAt.toIso8601String(),
    'deadline': deadline?.toIso8601String(), // Преобразование в строку
  };
}

factory Task.fromMap(Map<String, dynamic> map) {
  return Task(
    id: map['id'],
    title: map['title'],
    isCompleted: map['isCompleted'] == 1,
    createdAt: DateTime.parse(map['createdAt']),
    deadline: map['deadline'] != null ? DateTime.parse(map['deadline']) : null,
  );
}

}

