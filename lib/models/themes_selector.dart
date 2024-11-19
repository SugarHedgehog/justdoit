import 'package:flutter/material.dart';
import 'package:justdoit/themes.dart'; // Import your theme file

enum AppTheme {rei, asuka, shinji }

class ThemeSelector {
  static final Map<AppTheme, ThemeData> _themeDataMap = {
    AppTheme.rei: reiTheme,
    AppTheme.asuka: asukaTheme,
    AppTheme.shinji: shinjiTheme,
  };

  static final Map<AppTheme, String> _themeNameMap = {
    AppTheme.rei: 'Тема Рей',
    AppTheme.asuka: 'Тема Аска',
    AppTheme.shinji: 'Тема Синдзи',
  };

  static ThemeData getThemeData(AppTheme appTheme) {
    return _themeDataMap[appTheme] ?? reiTheme;
  }

  static String getBackgroundImage(AppTheme appTheme) {
    switch (appTheme) {
      case AppTheme.asuka:
        return 'assets/images/asuka.png';
      case AppTheme.rei:
        return 'assets/images/rei.png';
      case AppTheme.shinji:
        return 'assets/images/shinji.png';
      default:
        return 'assets/images/default.png'; // Fallback image
    }
  }
  static Future<AppTheme?> showThemeDialog(
      BuildContext context, AppTheme currentTheme) {
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
}
