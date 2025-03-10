import 'package:justdoit/resourse/data.dart';
import 'package:justdoit/task.dart';

 DateTime setdeadline(bool dateIsSet, bool timeIsSet,  dynamic selectedDate) {
    if (!dateIsSet && !timeIsSet) {
      return DateTime(0);
    }

    return selectedDate;
  }
bool saveTask(String text, String description, DateTime selectedDate, double rating, bool dateIsSet, bool timeIsSet) {
    if (text == '') {
      return false;
    } else {
      Task newTask = Task(
          textOfTask: text,
          descriptionOfTask: description,
          deadline: setdeadline(dateIsSet, timeIsSet, selectedDate),
          rating: rating,
          dateIsSet: dateIsSet,
          timeIsSet: timeIsSet);
      addTask(newTask);
      return true;
    }
  }

  Future<void> addTask(Task newTask) async {
    taskListUncheck.insert(0, newTask);
  }