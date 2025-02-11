import 'package:flutter/material.dart';
import 'package:justdoit/main.dart';
import 'package:justdoit/screens/addTask.dart';
import 'package:justdoit/task.dart';
import 'package:justdoit/resourse/data.dart';

class ListOfTask extends StatefulWidget {
  const ListOfTask({super.key, required this.title});
  final String title;

  @override
  State<ListOfTask> createState() => _ListOfTask();
}

class _ListOfTask extends State<ListOfTask> {
  
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
  Widget listViewCustom(List<Task> taskList, context) {
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
                return ListTile(
                  title: Text(task.textOfTask),
                  subtitle: Text(
                      '${task.descriptionOfTask} Сделать до ${task.deadline.toLocal().toString().split(' ').join(', ')}'),
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
            ),
          ),
        ),
      ),
    );
  }
}