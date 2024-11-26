import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';


Future<Task?> showEditTaskDialog(BuildContext context, Task task) {
  final TextEditingController titleController = TextEditingController(text: task.title);
  DateTime? selectedDeadline = task.deadline;

  return showDialog<Task>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Редактировать задачу'),
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
                              initialDate: selectedDeadline ?? DateTime.now(),
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
                              initialTime: TimeOfDay.fromDateTime(selectedDeadline ?? DateTime.now()),
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
              final updatedTask = Task(
                id: task.id,
                title: titleController.text,
                deadline: selectedDeadline,
                isCompleted: task.isCompleted,
                createdAt: task.createdAt,
              );
              Navigator.of(context).pop(updatedTask); // Return the updated task
            },
            child: const Text('Сохранить'),
          ),
        ],
      );
    },
  );
}