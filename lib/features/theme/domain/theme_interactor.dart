import 'package:flutter/material.dart';

import '../data/theme_repository.dart';

abstract class ThemeInteractor {
  Future<void> setThemeMode(ThemeMode themeMode);
  ThemeMode getThemeMode();
}

class ThemeInteractorImpl implements ThemeInteractor {
  final ThemeRepository _themeRepository;

  ThemeInteractorImpl(this._themeRepository);

  @override
  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _themeRepository.saveThemeMode(themeMode);
  }

  @override
  ThemeMode getThemeMode() {
    return _themeRepository.getSavedThemeMode();
  }
}
