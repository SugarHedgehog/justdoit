class Task {
  String textOfTask;
  String? descriptionOfTask;
  DateTime? deadline; // Теперь deadline может быть null
  bool check;
  double rating;

  Task({
    required this.textOfTask,
    this.descriptionOfTask,
    this.deadline, // deadline больше не обязательное поле
    this.check = false, 
    this.rating = 1.0,
  });
}
