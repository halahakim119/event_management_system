import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/theme/data/theme_mode_adapter.dart';
import '../../features/theme/data/theme_repository.dart';
import '../../features/theme/domain/theme_interactor.dart';
import '../../features/theme/presentation/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Initialize Hive
  await Hive.initFlutter();

  //! Register Hive Adapters
  Hive.registerAdapter(ThemeModeAdapter());
  
  //! Open the Hive box
  final themeBox = await Hive.openBox('themeBox');

  
sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(themeBox));
sl.registerLazySingleton<ThemeInteractor>(() => ThemeInteractorImpl(sl<ThemeRepository>()));
sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl<ThemeInteractor>()));

}
