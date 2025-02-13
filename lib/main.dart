import 'package:flutter/material.dart';
import 'package:justdoit/screens/addTask.dart';
import 'package:justdoit/screens/listOfTask.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => const ListOfTask(title: 'Дела для делания'),
      '/addtask': (context) => const AddTask(),
    }
));




