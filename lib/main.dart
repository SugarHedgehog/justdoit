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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
  State<ListOfTask> createState() => _ListOftaskListUnchecktate();
}

class _ListOftaskListUnchecktate extends State<ListOfTask> {
  List<Task> taskListUncheck = [
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
    Task(
        textOfTask: 'Sleep',
        descriptionOfTask: 'Long',
        deadline: DateTime(2023, 10, 15)),
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
      body:
          listViewCustom(taskListUncheck),
    );
  }

  ListView listViewCustom(List <Task> taskList) {
    return ListView.builder(
          itemCount: taskListUncheck.length,
          itemBuilder: (context, index) {
            final task = taskListUncheck[index];
            return ListTile(
              title: Text(task.textOfTask),
              subtitle: Text('${task.descriptionOfTask} Сделать до ${task.deadline.toLocal().toString().split(' ')[0]}'),
              //splashColor: Colors.amber,
              trailing: Checkbox(
                value: task.check,
                onChanged: (bool? value) {
                  setState(() {
                    task.check = task.check == false? true: false;
                    taskListCheck.add(task);
                    taskListUncheck.removeAt(index);
                  });
                },
              ),
            );
          },
        );
  }
}
