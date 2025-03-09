import 'package:flutter/material.dart';
import 'package:justdoit/resourse/data.dart';
import 'package:justdoit/task.dart';
import 'package:flutter_rating/flutter_rating.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String text = '';
  String description = '';
  DateTime selectedDate = DateTime.now();
  bool taskIsSave = false;
  bool dateIsSet = false;
  bool timeIsSet = false;
  double rating = 1;

  Future<DateTime?> pickDate() => showDatePicker(
      locale: const Locale("ru", "RU"),
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100));

  /// Opens time picker and returns possible `TimeOfDay` object.
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute));

  Future pickDateTime() async {
    DateTime? date = await pickDate();
    if (date == null) return;

    setState(() {
      dateIsSet = true;
      selectedDate = date;
    });

    final shouldPickTime = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Выбрать время?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Продолжить без времени'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Добавить время'),
          ),
        ],
      ),
    );

    if (shouldPickTime == true) {
      TimeOfDay? time = await pickTime();
      if (time != null) {
        setState(() {
          timeIsSet = true;
          selectedDate = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  DateTime setdeadline() {
    if (dateIsSet && timeIsSet) {
      return DateTime(selectedDate.year, selectedDate.month, selectedDate.day,
          selectedDate.hour, selectedDate.minute);
    }
    if (dateIsSet && !timeIsSet) {
      return DateTime(
          selectedDate.year, selectedDate.month, selectedDate.day, 0, 0, 10);
    }
    if (!dateIsSet && !timeIsSet) {
      return DateTime(0);
    }

    return DateTime(0);
  }

  bool saveTask(String text, String description, DateTime selectedDate, double rating) {
    if (text == '') {
      return false;
    } else {
      Task newTask = Task(
          textOfTask: text,
          descriptionOfTask: description,
          deadline: setdeadline(),
          rating: rating);
      addTask(newTask);
      return true;
    }
  }

  Future<void> addTask(Task newTask) async {
    taskListUncheck.insert(0, newTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить дело для делания'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                onChanged: (String? value) => {text = value!},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Задача',
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                onChanged: (String? value) => {description = value!},
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Описание',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 5,
              children: [
                const Text("Важность:"),
                StarRating(
                  size: 30.0,
                  rating: rating,
                  filledIcon: Icons.av_timer,
                  halfFilledIcon: Icons.av_timer,
                  emptyIcon: Icons.av_timer,
                  color: Colors.deepPurpleAccent, // Color for filled and half-filled icons
                  borderColor: Colors.grey, // Color for empty icons
                  onRatingChanged: (rat) => setState(() => rating = rat),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: pickDateTime,
                    tooltip: "Добавить дату и время",
                    icon: const Icon(Icons.calendar_month)),
                if (dateIsSet)
                  Text(
                    'Дата: ${selectedDate.day}.${selectedDate.month}.${selectedDate.year}'
                    '${timeIsSet ? ' Время: ${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}' : ''}',
                    style: const TextStyle(fontSize: 12),
                  )
                else
                  const Text('Дедлайн не отмечен'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => {
                          taskIsSave =
                              saveTask(text, description, selectedDate, rating),
                          if (taskIsSave)
                            {Navigator.pop(context, taskIsSave)}
                          else
                            {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Введите текст задачи')),
                              )
                            },
                        },
                    child: const Text('Сохранить')),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () => {Navigator.pop(context, false)},
                    child: const Text('Удалить'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
