import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

abstract class ThemeRepository {
  Future<void> saveThemeMode(ThemeMode themeMode);
  ThemeMode getSavedThemeMode();
}

class ThemeRepositoryImpl implements ThemeRepository {
  static const String _themeModeKey = 'themeMode';

  final Box _themeBox;

  ThemeRepositoryImpl(this._themeBox);

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await _themeBox.put(_themeModeKey, themeMode.index);
  }

  @override
  ThemeMode getSavedThemeMode() {
    final int? savedThemeModeIndex = _themeBox.get(_themeModeKey);
    if (savedThemeModeIndex != null) {
      return ThemeMode.values[savedThemeModeIndex];
    } else {
      return ThemeMode.light;
    }
  }
}
