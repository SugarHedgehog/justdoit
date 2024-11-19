import 'package:flutter/material.dart';
import 'package:justdoit/screens/add_task_screen.dart';
import 'package:justdoit/models/themes_selector.dart';
import 'package:justdoit/widgets/task_list.dart';
import '../db/database_helper.dart';
import '../models/task.dart';

enum Filter { all, completed, pending }

class TaskListScreen extends StatefulWidget {
  final Function(AppTheme) onThemeChanged;

  const TaskListScreen({super.key, required this.onThemeChanged});

  @override
  TaskListScreenState createState() => TaskListScreenState();
}

class TaskListScreenState extends State<TaskListScreen> {
  Filter _filter = Filter.all;
  AppTheme _appTheme = AppTheme.rei;
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Task> _tasks = []; // Local list of tasks
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks initially
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await _dbHelper.getTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error, e.g., show a snackbar or dialog
    }
  }

  void _updateTask(Task task) async {
    await _dbHelper.updateTask(task);
    setState(() {
      // Update the local task list
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
      }
    });
  }

  Future<void> _deleteTask(String taskId) async {
    await _dbHelper.deleteTask(taskId);
    setState(() {
      _tasks.removeWhere((task) => task.id == taskId);
    });
  }

  Future<void> _showThemeDialog() async {
    final selectedTheme =
        await ThemeSelector.showThemeDialog(context, _appTheme);
    if (selectedTheme != null && selectedTheme != _appTheme) {
      setState(() {
        _appTheme = selectedTheme;
      });
      widget.onThemeChanged(selectedTheme);
    }
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _tasks.isEmpty
              ? const Center(child: Text('Нет задач'))
              : Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          ThemeSelector.getBackgroundImage(_appTheme)),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.3),
                        BlendMode.dstATop,
                      ),
                    ),
                  ),
                  child: TaskList(
                    tasks: _tasks.where((task) {
                      if (_filter == Filter.completed) return task.isCompleted;
                      if (_filter == Filter.pending) return !task.isCompleted;
                      return true;
                    }).toList(),
                    onTaskToggle: (task) {
                      setState(() {
                        task.isCompleted = !task.isCompleted;
                      });
                      _updateTask(task);
                    },
                    onTaskDelete: _deleteTask,
                    onTaskLongPress: (task) async {
                      bool? confirmDelete = await showDialog<bool>(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Подтверждение удаления'),
                            content: const Text(
                                'Вы уверены, что хотите удалить эту задачу?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(
                                      false); // Возвращает false при нажатии "Нет"
                                },
                                child: const Text('Нет'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(
                                      true); // Возвращает true при нажатии "Да"
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
                ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.brightness_6),
              tooltip: 'Сменить тему',
              onPressed: _showThemeDialog,
            ),
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Добавить задачу',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddTaskScreen()),
                ).then((_) {
                  _loadTasks(); // Reload tasks after adding a new one
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
