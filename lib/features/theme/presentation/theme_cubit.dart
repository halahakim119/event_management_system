import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/theme_interactor.dart';

enum ThemeEvent { loadTheme, setTheme }

class ThemeCubit extends Cubit<ThemeMode> {
  final ThemeInteractor _themeInteractor;

  ThemeCubit(this._themeInteractor) : super(ThemeMode.light);

  Future<void> loadThemeMode() async {
    final savedThemeMode = _themeInteractor.getThemeMode();
    emit(savedThemeMode);
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _themeInteractor.setThemeMode(themeMode);
    emit(themeMode);
  }

  Future<void> toggleTheme() async {
    final currentThemeMode = _themeInteractor.getThemeMode();
    final newThemeMode =
        currentThemeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _themeInteractor.setThemeMode(newThemeMode);
    emit(newThemeMode);
  }
}
