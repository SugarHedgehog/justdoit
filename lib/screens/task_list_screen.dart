import 'package:flutter/material.dart';
import 'package:justdoit/models/themes_selector.dart';
import 'package:justdoit/screens/add_task_screen.dart';
import 'package:justdoit/screens/edit_task_screen.dart';
import 'package:justdoit/widgets/task_list.dart';
import '../repositories/task_repository.dart';
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
  final TaskRepository _taskRepository = TaskRepository();
  List<Task> _tasks = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final tasks = await _taskRepository.getTasks();
      setState(() {
        _tasks = tasks;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateTask(Task task) async {
    await _taskRepository.updateTask(task);
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
      }
    });
  }

  Future<void> _deleteTask(String taskId) async {
    await _taskRepository.deleteTask(taskId);
    setState(() {
      _tasks.removeWhere((task) => task.id == taskId);
    });
  }

  Future<void> _editTask(Task task) async {
    final updatedTask = await showEditTaskDialog(context, task);
    if (updatedTask != null) {
      _updateTask(updatedTask);
      _loadTasks();
    }
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

  Future<void> _addTask() async {
    final newTask = await showAddTaskDialog(context);
    if (newTask != null) {
      await _taskRepository.addTask(newTask);
      _loadTasks();
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
                    onTaskEdit: _editTask,
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
              onPressed: _addTask,
            ),
          ],
        ),
      ),
    );
  }
}
