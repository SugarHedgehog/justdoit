import 'package:flutter/material.dart';
import 'screens/task_list_screen.dart'; // Импортируйте экран списка задач

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Сделай и Точка',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TaskListScreen(), // Укажите, что домашний экран - это экран списка задач
    );
  }
}
