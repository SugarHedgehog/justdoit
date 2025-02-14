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
  DateTime selectedDate = DateTime(0);
  bool taskIsSave = false;

  bool saveTask(String text, String description, DateTime selectedDate) {
    if (text == '') {
      return false;
    } else {
      Task newTask = Task(
          textOfTask: text,
          descriptionOfTask: description,
          deadline: selectedDate);
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
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          spacing: 20,
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
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Дата',
                ),
              ),
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
