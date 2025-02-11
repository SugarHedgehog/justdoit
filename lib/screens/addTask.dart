import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String text = '';
  String description = '';
  DateTime selectedDate =
  DateTime.now(); // Переменная для хранения выбранной даты

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
                    onPressed: () => {}, child: const Text('Сохранить')),
                const SizedBox(width: 20),
                ElevatedButton(
                    onPressed: () => {}, child: const Text('Удалить'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
