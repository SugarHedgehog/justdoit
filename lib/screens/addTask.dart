import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String text = '';
  String description = '';
  DateTime selectedDate =
      DateTime.now(); // Переменная для хранения выбранной даты

  // Функция для отображения диалогового окна выбора даты
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked; // Обновляем состояние с новой датой
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить дело для делания'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Задача:'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextFormField(
                  onSaved: (String? value) {
                    text = value!;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Описание:'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextFormField(
                  onSaved: (String? value) {
                    description = value!;
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Дата:'),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: GestureDetector(
                  onTap: () => _selectDate(
                      context), // Вызываем функцию выбора даты при нажатии
                  child: AbsorbPointer(
                    // Блокируем ввод текста
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "${selectedDate.toLocal()}"
                            .split(' ')[0], // Отображаем выбранную дату
                      ),
                      onSaved: (String? value) {
                        // Сохраняем дату в строковом формате, если это необходимо
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}