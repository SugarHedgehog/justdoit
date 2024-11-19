import 'package:flutter/material.dart';

final ThemeData reiTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  hintColor: Colors.redAccent,
  scaffoldBackgroundColor: Colors.white,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black54),
    displayLarge: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.redAccent,
  ),
  colorScheme: const ColorScheme.light(surface: Colors.white),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.blue,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  ),
  secondaryHeaderColor: Colors.blueAccent,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.black,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? Colors.blue : null),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? Colors.blue : null),
  ),
);

final ThemeData asukaTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.red,
  hintColor: Colors.orange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.red,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.red, fontSize: 24, fontWeight: FontWeight.bold),
    bodyLarge: TextStyle(color: Colors.black, fontSize: 16),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.red,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orange,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.red.shade700,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      foregroundColor: Colors.black,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? Colors.red : null),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? Colors.red : null),
  ),
  secondaryHeaderColor: Colors.redAccent,
  colorScheme: const ColorScheme.light(surface: Colors.white),
  dividerColor: Colors.grey.shade300,
);

final ThemeData shinjiTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(
    secondary: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.blueGrey),
    bodyMedium: TextStyle(color: Colors.grey),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.blueGrey,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.blueGrey,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.white70,
  ),
  dividerColor: Colors.grey.shade300,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? Colors.blueGrey : null),
  ),
  radioTheme: RadioThemeData(
    fillColor: WidgetStateProperty.resolveWith((states) =>
        states.contains(WidgetState.selected) ? Colors.blueGrey : null),
  ),
  hintColor: Colors.grey,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blueGrey,
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.grey,
  ),
  secondaryHeaderColor: Colors.blueGrey.shade700,
);