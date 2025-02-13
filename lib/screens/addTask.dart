import 'package:flutter/material.dart';
import 'package:justdoit/resourse/data.dart';
import 'package:justdoit/task.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String text = '';
  String description = '';
  DateTime selectedDate = DateTime(0);

  bool saveTask(String text, String description, DateTime selectedDate) {
    if (text == '') {
      print('Введите текст');
    } else {
      Task newTask = Task(
          textOfTask: text,
          descriptionOfTask: description,
          deadline: selectedDate);
      AddTask(newTask);
      return true;
    }
    return false;
  }

  void AddTask(Task newTask){
    taskListUncheck.insert(0, newTask);
      print('задача добавлена');
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
                    onPressed: () =>
                        {if(saveTask(text, description, selectedDate)){
                          Navigator.pop(context,{})},
                        },
                    child: const Text('Сохранить')),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () => {Navigator.pop(context,{})}, child: const Text('Удалить'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
