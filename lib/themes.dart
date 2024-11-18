import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  // Add more theme properties as needed
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blueGrey,
  // Add more theme properties as needed
);

final ThemeData reiTheme = ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(
    secondary: Colors.lightBlueAccent,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.blue), // Replaces bodyText1
    bodyMedium: TextStyle(color: Colors.blueAccent), // Replaces bodyText2
  ),
  // Add other theme parameters if necessary
);

/* final ThemeData asukaTheme = ThemeData(
  primarySwatch: Colors.red,
  primaryColor: Colors.red,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(
    secondary: Colors.redAccent,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.red), // Replaces bodyText1
    bodyMedium: TextStyle(color: Colors.redAccent), // Replaces bodyText2
  ),
  // Add other theme parameters if necessary
); */

final ThemeData asukaTheme = ThemeData(
  primaryColor: Colors.red,
  hintColor: Colors.orange,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.red,
    iconTheme: IconThemeData(color: Colors.white),
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
);

final ThemeData shinjiTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  primaryColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey).copyWith(
    secondary: Colors.grey,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.blueGrey), // Replaces bodyText1
    bodyMedium: TextStyle(color: Colors.grey), // Replaces bodyText2
  ),
  // Add other theme parameters if necessary
);