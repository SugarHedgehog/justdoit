import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import 'package:uuid/uuid.dart';

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
                  id: const Uuid().v4(), // Generate a unique ID for the new task
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