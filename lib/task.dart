class Task {
  String textOfTask;
  String descriptionOfTask;
  DateTime deadline;
  bool check;

  Task({
    required this.textOfTask,
    required this.descriptionOfTask,
    required this.deadline,
    this.check = false, 
  });
}