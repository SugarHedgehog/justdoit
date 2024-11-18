import 'package:flutter/material.dart';
import 'package:justdoit/themes.dart'; // Import your theme file

enum AppTheme { light, dark, rei, asuka, shinji }

class ThemeSelector {
  static final Map<AppTheme, ThemeData> _themeDataMap = {
    AppTheme.light: lightTheme,
    AppTheme.dark: darkTheme,
    AppTheme.rei: reiTheme,
    AppTheme.asuka: asukaTheme,
    AppTheme.shinji: shinjiTheme,
  };

  static final Map<AppTheme, String> _themeNameMap = {
    AppTheme.light: 'Светлая тема',
    AppTheme.dark: 'Темная тема',
    AppTheme.rei: 'Тема Рей',
    AppTheme.asuka: 'Тема Аска',
    AppTheme.shinji: 'Тема Синдзи',
  };

  static Future<AppTheme?> showThemeDialog(BuildContext context, AppTheme currentTheme) {
    return showDialog<AppTheme>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Выберите тему'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: AppTheme.values.map((theme) {
              return RadioListTile<AppTheme>(
                title: Text(_themeNameMap[theme]!),
                value: theme,
                groupValue: currentTheme,
                onChanged: (AppTheme? value) {
                  Navigator.of(context).pop(value);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  static ThemeData getThemeData(AppTheme theme) {
    return _themeDataMap[theme] ?? lightTheme;
  }
}