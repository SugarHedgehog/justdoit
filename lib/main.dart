import 'package:flutter/material.dart';
import 'package:justdoit/screens/add_task_screen.dart';
import 'package:justdoit/screens/list_of_task.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => const ListOfTaskScreen(title: 'Дела для делания'),
      '/addtask': (context) => const AddTaskScreen(),
    }));
