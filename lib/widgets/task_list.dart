import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final ValueChanged<Task> onTaskToggle;
  final ValueChanged<String> onTaskDelete;
  final Future<void> Function(Task) onTaskLongPress;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onTaskToggle,
    required this.onTaskDelete,
    required this.onTaskLongPress,
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
          onLongPress: () async {
            try {
              await onTaskLongPress(task);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('An error occurred: $e')));
            }
          },
        );
      },
    );
  }
}