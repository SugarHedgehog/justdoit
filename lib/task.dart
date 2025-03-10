class Task {
  String textOfTask;
  String? descriptionOfTask;
  DateTime deadline; // Теперь deadline может быть null
  bool check;
  double rating;
  bool dateIsSet;
  bool timeIsSet;

  Task({
    required this.textOfTask,
    this.descriptionOfTask,
    required this.deadline, // deadline больше не обязательное поле
    this.check = false, 
    this.rating = 1.0,
    this.dateIsSet = false,
    this.timeIsSet = false,
  });
}
