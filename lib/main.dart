import 'package:flutter/material.dart';
import 'package:justdoit/task.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ListOfTask(title: 'Дела для делания'),
    );
  }
}

class ListOfTask extends StatefulWidget {
  const ListOfTask({super.key, required this.title});
  final String title;

  @override
  State<ListOfTask> createState() => _ListOfTask();
}

class _ListOfTask extends State<ListOfTask> {
  List<Task> taskListUncheck = [
    Task(
        textOfTask: '1',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '2',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '3',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '4',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '5',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '6',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '7',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '8',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '9',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
    Task(
        textOfTask: '10',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15, 10, 12)),
  ];

  List<Task> taskListCheck = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text('Ещё дела не поделаны'),
          Expanded(child: listViewCustom(taskListUncheck)),
          const Text('Уже дела поделаны'),
          Expanded(child: listViewCustom(taskListCheck))
        ],
      ),
      floatingActionButton: IconButton.filled(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTask()),
          );
        },
        icon: const Icon(Icons.add),
      ),
    );
  }

  ListView listViewCustom(List<Task> taskList) {
    return ListView.builder(
      itemCount: taskList.length,
      itemBuilder: (context, index) {
        final task = taskList[index];
        return ListTile(
          title: Text(task.textOfTask),
          subtitle: Text(
              '${task.descriptionOfTask} Сделать до ${task.deadline.toLocal().toString().split(' ').join(', ')}'),
          //splashColor: Colors.amber,
          trailing: Checkbox(
            value: task.check,
            onChanged: (bool? value) {
              setState(() {
                if (task.check == false) {
                  taskListCheck.add(task);
                  taskListUncheck.removeAt(index);
                  task.check = true;
                } else {
                  taskListUncheck.insert(0, task);
                  taskListCheck.removeAt(index);
                  task.check = false;
                }
              });
            },
          ),
        );
      },
    );
  }
}

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String text = '';
  String description = '';
  DateTime selectedDate = DateTime.now(); // Переменная для хранения выбранной даты

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
                  onTap: () => _selectDate(context), // Вызываем функцию выбора даты при нажатии
                  child: AbsorbPointer( // Блокируем ввод текста
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "${selectedDate.toLocal()}".split(' ')[0], // Отображаем выбранную дату
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

