import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:justdoit/models/themes_selector.dart';
import 'package:justdoit/screens/edit_task_screen.dart';
import 'package:justdoit/widgets/task_list.dart';
import '../repositories/task_repository.dart';
import '../models/task.dart';
import 'package:uuid/uuid.dart';

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
      // Handle error, e.g., show a snackbar or dialog
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
      _loadTasks(); // Refresh the task list
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
      _loadTasks(); // Refresh the task list
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

Future<Task?> showAddTaskDialog(BuildContext context) {
  final TextEditingController titleController = TextEditingController();
  DateTime? selectedDeadline;

  return showDialog<Task>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Добавить задачу'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Название задачи'),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(selectedDeadline != null
                        ? 'Дедлайн: ${DateFormat.yMMMd().add_Hm().format(selectedDeadline!)}'
                        : 'Дедлайн: Не установлен'),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDeadline = DateTime(
                                  pickedDate.year,
                                  pickedDate.month,
                                  pickedDate.day,
                                  selectedDeadline?.hour ?? 0,
                                  selectedDeadline?.minute ?? 0,
                                );
                              });
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.access_time),
                          onPressed: () async {
                            final TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (pickedTime != null) {
                              setState(() {
                                selectedDeadline = DateTime(
                                  selectedDeadline?.year ?? DateTime.now().year,
                                  selectedDeadline?.month ?? DateTime.now().month,
                                  selectedDeadline?.day ?? DateTime.now().day,
                                  pickedTime.hour,
                                  pickedTime.minute,
                                );
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog without saving
            },
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final newTask = Task(
                  id: Uuid().v4(), // Generate a unique ID for the new task
                  title: titleController.text,
                  deadline: selectedDeadline,
                  isCompleted: false,
                  createdAt: DateTime.now(),
                );
                Navigator.of(context).pop(newTask); // Return the new task
              }
            },
            child: const Text('Сохранить'),
          ),
        ],
      );
    },
  );
}