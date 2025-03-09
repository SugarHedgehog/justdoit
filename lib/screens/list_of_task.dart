import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:justdoit/task.dart';
import 'package:justdoit/resourse/data.dart';

class ListOfTaskScreen extends StatefulWidget {
  const ListOfTaskScreen({super.key, required this.title});
  final String title;
  @override
  State<ListOfTaskScreen> createState() => _ListOfTaskScreen();
}

class _ListOfTaskScreen extends State<ListOfTaskScreen> {
  String formatDeadlineDate(DateTime deadline) {
    initializeDateFormatting('ru_RU', null);
    return DateFormat('d MMMM yyyy', 'ru_RU').format(deadline);
  }

  String formatDeadlineTime(DateTime deadline) {
    initializeDateFormatting('ru_RU', null);
    return DateFormat('H:mm', 'ru_RU').format(deadline);
  }

  bool _taskIsSave = false;

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
          Expanded(child: listViewCustom(taskListUncheck, context)),
          const Text('Уже дела поделаны'),
          Expanded(child: listViewCustom(taskListCheck, context))
        ],
      ),
      floatingActionButton: IconButton.filled(
        onPressed: () async {
          final taskIsSave = await Navigator.pushNamed(context, '/addtask');
          setState(() {
            _taskIsSave = taskIsSave as bool;
          });
          if (_taskIsSave == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Задача добавлена')),
            );
            _taskIsSave = false;
          }
        },
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget listViewCustom(List<Task> taskList, context) {
    final List<Color> ratingColors = [
      Colors.blue[50]!,    
      Colors.green[50]!,   
      Colors.yellow[50]!,  
      Colors.orange[50]!,  
      Colors.red[50]!, 
      Colors.red[400]!, 
    ];
    
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white, // Цвет фона контейнера
            borderRadius: BorderRadius.circular(15.0), // Радиус скругления
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, // Цвет тени
                blurRadius: 5.0, // Размытие тени
                offset: Offset(0, 2), // Смещение тени
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(15.0), // Обеспечивает скругление краев
            child: ListView.builder(
              itemCount: taskList.length,
              itemBuilder: (context, index) {
                final task = taskList[index];
                String deadlineDate = formatDeadlineDate(task.deadline!);
                String deadlineTime = formatDeadlineTime(task.deadline!);
                bool dateIsSet = task.deadline!.year == 0;
                bool timeIsSet = task.deadline!.second != 0;
                
                // Получаем цвет из массива по рейтингу (с проверкой на валидный индекс)
                Color itemColor = Colors.grey[50]!; // Цвет по умолчанию
                if (task.rating >= 1 && task.rating <= 5) {
                  itemColor = ratingColors[task.rating.toInt() - 1]; // -1 потому что индексы с 0, а рейтинг с 1
                }

                if(!task.check && (!dateIsSet || timeIsSet) && DateTime.now().compareTo(task.deadline!) == 1){
                  itemColor = ratingColors[ratingColors.length - 1];
                }
                
                return Container(
                  color: itemColor,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: ListTile(
                    title: Text(task.textOfTask),
                    subtitle: Text(
                        '${task.descriptionOfTask ?? ''} ${dateIsSet ? '' : 'Сделать до $deadlineDate${timeIsSet ? ' $deadlineTime' : ''}'}'),
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
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
