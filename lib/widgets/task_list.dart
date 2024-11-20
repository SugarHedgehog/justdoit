import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final ValueChanged<Task> onTaskToggle;
  final ValueChanged<String> onTaskDelete;
  final Future<void> Function(Task) onTaskEdit;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onTaskToggle,
    required this.onTaskDelete,
    required this.onTaskEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        final isOverdue = task.deadline != null &&
            task.deadline!.isBefore(DateTime.now()) &&
            !task.isCompleted;

        return ListTile(
          title: Text(
            task.title,
            style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.bold,
              color: task.isCompleted ? Colors.grey : (isOverdue ? Colors.red : null),
            ),
          ),
          subtitle: task.deadline != null
              ? Text('До: ${DateFormat.yMMMd().add_Hm().format(task.deadline!)}')
              : null,
          trailing: Checkbox(
            value: task.isCompleted,
            onChanged: (bool? value) {
              if (value != null) {
                onTaskToggle(task);
              }
            },
          ),
          onTap: () {
            _showTaskOptions(context, task);
          },
        );
      },
    );
  }

  void _showTaskOptions(BuildContext context, Task task) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Редактировать'),
              onTap: () async {
                Navigator.pop(context);
                await onTaskEdit(task);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Удалить'),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, task.title);
              },
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, String taskId) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Подтверждение удаления'),
          content: const Text('Вы уверены, что хотите удалить эту задачу?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Нет'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Да'),
            ),
          ],
        );
      },
    ).then((confirmDelete) {
      if (confirmDelete == true) {
        onTaskDelete(taskId);
      }
    });
  }
}