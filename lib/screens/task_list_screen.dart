import 'package:flutter/material.dart';
import 'package:justdoit/screens/add_task_screen.dart';
import '../db/database_helper.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

enum Filter { all, completed, pending }

Filter _filter = Filter.all;

class _TaskListScreenState extends State<TaskListScreen> {
  late Future<List<Task>> tasks;

  @override
  void initState() {
    super.initState();
    tasks = DatabaseHelper().getTasks(); // Получение задач из базы данных
  }

  void _updateTask(Task task) async {
    final db = DatabaseHelper();
    await db
        .updateTask(task); // Создайте метод updateTask в классе DatabaseHelper
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список задач'),
        actions: [
          DropdownButton<Filter>(
            value: _filter,
            onChanged: (Filter? newValue) {
              setState(() {
                _filter = newValue!;
              });
            },
            items: const [
              DropdownMenuItem(value: Filter.all, child: Text('Все')),
              DropdownMenuItem(
                  value: Filter.completed, child: Text('Завершенные')),
              DropdownMenuItem(
                  value: Filter.pending, child: Text('Незавершенные')),
            ],
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

// Фильтрация задач в зависимости от выбранного фильтра
          final filteredTasks = taskList.where((task) {
            if (_filter == Filter.completed) return task.isCompleted;
            if (_filter == Filter.pending) return !task.isCompleted;
            return true; // Все задачи
          }).toList();

          return ListView.builder(
            itemCount: filteredTasks.length,
            itemBuilder: (context, index) {
              final task = filteredTasks[index];
              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration:
                        task.isCompleted ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (bool? value) {
                    setState(() {
                      task.isCompleted = value!;
                      _updateTask(task);
                    });
                  },
                ),
                onLongPress: () async {
                  await DatabaseHelper().deleteTask(task.id);
                  setState(() {
                    tasks = DatabaseHelper().getTasks();
                  });
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddTaskScreen()),
              ).then((_) {
                setState(() {
                  tasks = DatabaseHelper().getTasks(); // Refresh the task list
                });
              });
            },
            tooltip: 'Добавить задачу',
            child: const Icon(Icons.add),
      ),
    );
  }
}

