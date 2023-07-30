import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_system/translations/codegen_loader.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/injection/injection_container.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/theme/presentation/theme_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await init();
  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: const [
      Locale('en'),
      Locale('ar'),
    ],
    fallbackLocale: const Locale('en'),
    assetLoader: const CodegenLoader(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeCubit>(
      create: (context) {
        // Initialize ThemeCubit and load the saved theme mode
        final themeCubit = sl<ThemeCubit>();
        themeCubit.loadThemeMode();
        return themeCubit;
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp.router(
            // easy localization
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            debugShowCheckedModeBanner: false,

            // app theme
            theme: themeMode == ThemeMode.light
                ? AppTheme.themeData
                : AppTheme.darkTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,

            // app routing
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
