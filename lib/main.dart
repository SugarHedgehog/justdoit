import 'package:flutter/material.dart';
import 'package:justdoit/screens/add_task_screen.dart';
import 'package:justdoit/screens/list_of_task.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:justdoit/screens/loading_screen.dart';

void main() => runApp(MaterialApp(
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('ru'),
    ],
    initialRoute: '/',
    routes: {
      '/': (context) => const LoadingScreen(),
      '/home': (context) => const ListOfTaskScreen(title: 'Дела для делания'),
      '/addtask': (context) => const AddTaskScreen(),
    }));
