import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';
import 'package:uuid/uuid.dart'; // Для генерации уникальных идентификаторов

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controller = TextEditingController();

  void _addTask() async {
    final String title = _controller.text.trim();
    if (title.isNotEmpty) {
      final task = Task(
        id: const Uuid().v4(), // Генерация уникального идентификатора
        title: title,
        createdAt: DateTime.now(),
      );
      await DatabaseHelper().insertTask(task);
      Navigator.pop(context); // Закрытие экрана добавления задачи
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить задачу'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Название задачи'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
