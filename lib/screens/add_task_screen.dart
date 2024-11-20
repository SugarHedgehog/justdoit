import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/task.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart'; // Add this import for date formatting

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  AddTaskScreenState createState() => AddTaskScreenState();
}

class AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _addTask() async {
    final String title = _controller.text.trim();
    if (title.isNotEmpty) {
      final task = Task(
        id: const Uuid().v4(),
        title: title,
        createdAt: DateTime.now(),
        deadline: _selectedDate != null && _selectedTime != null
            ? DateTime(
                _selectedDate!.year,
                _selectedDate!.month,
                _selectedDate!.day,
                _selectedTime!.hour,
                _selectedTime!.minute,
              )
            : null,
      );
      await DatabaseHelper().insertTask(task);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить задачу'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Название задачи'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () => _selectDate(context),
                ),
                IconButton(
                  icon: const Icon(Icons.access_time),
                  onPressed: () => _selectTime(context),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (_selectedDate != null)
              Text(
                  'Выбранная дата: ${DateFormat.yMd().format(_selectedDate!)}'),
            if (_selectedTime != null)
              Text('Выбранное время: ${_selectedTime!.format(context)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addTask,
              child: const Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
