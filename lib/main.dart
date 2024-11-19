import 'package:flutter/material.dart';
import 'package:justdoit/screens/task_list_screen.dart';
import 'package:justdoit/models/themes_selector.dart'; // Import the theme selector

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  AppTheme _appTheme = AppTheme.rei; // Default theme

  void _changeTheme(AppTheme newTheme) {
    setState(() {
      _appTheme = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeSelector.getThemeData(_appTheme),
      home: TaskListScreen(onThemeChanged: _changeTheme),
    );
  }
}