class Task {
  final String id;
  final String title;
  bool isCompleted;
  final DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
  return {
    'id': id,
    'title': title,
    'isCompleted': isCompleted,
    'createdAt': createdAt.toIso8601String(),//преобразовалка в красивую дату
  };
}

factory Task.fromMap(Map<String, dynamic> map) {
  return Task(
    id: map['id'],
    title: map['title'],
    isCompleted: map['isCompleted'] == 1,
    createdAt: DateTime.parse(map['createdAt']),
  );
}

}

