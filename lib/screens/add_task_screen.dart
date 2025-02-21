import 'package:flutter/material.dart';
import 'package:justdoit/resourse/data.dart';
import 'package:justdoit/task.dart';

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

  Future<DateTime?> pickDate() => showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100)
  );

  /// Opens time picker and returns possible `TimeOfDay` object.
  Future<TimeOfDay?> pickTime() => showTimePicker(
      context: context,
      initialTime:
          TimeOfDay(hour: selectedDate.hour, minute: selectedDate.minute));

  bool saveTask(String text, String description, DateTime selectedDate) {
    if (text == '') {
      return false;
    } else {
      Task newTask = Task(
          textOfTask: text,
          descriptionOfTask: description,
          deadline: DateTime(selectedDate.year, selectedDate.month,
              selectedDate.day, selectedDate.hour, selectedDate.minute));
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
            Navigator.pop(context, false); // Возврат на предыдущий экран
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
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
            /* SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Дата',
                ),
              ),
            ), */
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 5.0,
              children: [
                IconButton(
                    onPressed: () async {
                        final newDate = await pickDate();
                        if (newDate == null) return; // person pressed 'CANCEL'

                        // Update datetime object that's shown with new date
                        final newDateTime = DateTime(newDate.year, newDate.month, newDate.day, selectedDate.hour, selectedDate.minute);
                        setState(
                          () => selectedDate = newDateTime,
                        );
                      },
                    icon: const Icon(Icons.calendar_month)),
                IconButton(
                    onPressed: () async {
                        final newTime = await pickTime();
                        if (newTime == null) return; // person pressed 'CANCEL'

                        // Update datetime object that's shown with new time
                        final newDateTime = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, newTime.hour, newTime.minute);
                        setState(
                          () => selectedDate = newDateTime,
                        );
                      }, icon: const Icon(Icons.schedule)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () => {
                          taskIsSave =
                              saveTask(text, description, selectedDate),
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
