import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

abstract class SettingsLocalDataSource {
  Future<bool> getThemeMode();
  Future<void> saveThemeMode(bool isDarkMode);
  Future<Color> getSelectedColor();
  Future<void> saveSelectedColor(Color color);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  static const String _themeKey = 'isDarkMode';
  static const String _colorKey = 'selectedColor';
  static const String _settingsBox = 'settingsBox';

  @override
  Future<bool> getThemeMode() async {
    final box = await Hive.openBox(_settingsBox);
    return box.get(_themeKey, defaultValue: false);
  }

  @override
  Future<void> saveThemeMode(bool isDarkMode) async {
    final box = await Hive.openBox(_settingsBox);
    await box.put(_themeKey, isDarkMode);
  }

  @override
  Future<Color> getSelectedColor() async {
    final box = await Hive.openBox(_settingsBox);
    final colorValue = box.get(_colorKey, defaultValue: Colors.blue);
    return Color(colorValue);
  }

  @override
  Future<void> saveSelectedColor(Color color) async {
    final box = await Hive.openBox(_settingsBox);
    await box.put(_colorKey, color);
  }
}
