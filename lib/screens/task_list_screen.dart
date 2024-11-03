import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = DatabaseHelper().getTasks(); // Получение задач из базы данных
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список задач'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()),
              ).then((_) {
                setState(() {
                  tasks = DatabaseHelper().getTasks(); // Обновление списка задач
                });
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Task>>(
        future: tasks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет задач'));
          }

          final taskList = snapshot.data!;
          return ListView.builder(
            itemCount: taskList.length,
            itemBuilder: (context, index) {
              final task = taskList[index];
              return ListTile(
                title: Text(task.title),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    setState(() {
                      // Обновление статуса задачи
                      task.isCompleted = value!;
                      // Здесь можно добавить код для обновления задачи в базе данных
                    });
                  },
                ),
                onLongPress: () {
                  // Здесь можно добавить код для удаления задачи
                },
              );
            },
          );
        },
      ),
    );
  }
}
