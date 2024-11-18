import 'package:flutter/material.dart';
import 'package:justdoit/screens/add_task_screen.dart';
import 'package:justdoit/models/themes_selector.dart'; // Import the theme selector
import '../db/database_helper.dart';
import '../models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  TaskListScreenState createState() => TaskListScreenState();
}

enum Filter { all, completed, pending }

class TaskListScreenState extends State<TaskListScreen> {
  Filter _filter = Filter.all;
  AppTheme _appTheme = AppTheme.light; // Default theme
  late Future<List<Task>> tasks;
  late ThemeData _currentTheme; // Declare without initialization

  @override
  void initState() {
    super.initState();
    tasks = DatabaseHelper().getTasks(); // Получение задач из базы данных
    _currentTheme = ThemeSelector.getThemeData(_appTheme); // Initialize here
  }

  void _updateTask(Task task) async {
    final db = DatabaseHelper();
    await db.updateTask(task);
  }

  Future<void> _deleteTask(String taskId) async {
    await DatabaseHelper().deleteTask(taskId);
    setState(() {
      tasks = DatabaseHelper().getTasks(); // Refresh the task list
    });
  }

  void _showThemeDialog() async {
    final selectedTheme = await ThemeSelector.showThemeDialog(context, _appTheme);
    if (selectedTheme != null && selectedTheme != _appTheme) {
      setState(() {
        _appTheme = selectedTheme;
        _currentTheme = ThemeSelector.getThemeData(_appTheme);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _currentTheme,
      home: Scaffold(
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
                DropdownMenuItem(value: Filter.completed, child: Text('Завершенные')),
                DropdownMenuItem(value: Filter.pending, child: Text('Незавершенные')),
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
                return Opacity(
                  opacity: task.isCompleted ? 0.5 : 1.0,
                  child: ListTile(
                    title: Text(
                      task.title,
                      style: TextStyle(
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
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
                      bool? confirmDelete = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Подтверждение удаления'),
                            content: const Text('Вы уверены, что хотите удалить эту задачу?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(false); // Return false when "No" is pressed
                                },
                                child: const Text('Нет'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(true); // Return true when "Yes" is pressed
                                },
                                child: const Text('Да'),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirmDelete == true) {
                        await _deleteTask(task.id);
                      }
                    },
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.brightness_6), // Icon for theme change
                onPressed: _showThemeDialog,
              ),
              IconButton(
                icon: const Icon(Icons.add), // Icon for adding a task
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}