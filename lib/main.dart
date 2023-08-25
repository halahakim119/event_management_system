import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_support/overlay_support.dart';

import 'core/injection/injection_container.dart';
import 'core/network/internet_checker.dart';
import 'core/network/no_internet.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'features/theme/presentation/theme_cubit.dart';
import 'translations/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await EasyLocalization.ensureInitialized();
  bool isConnected = await sl<InternetChecker>().checkInternet();

  if (isConnected) {
    runApp(OverlaySupport.global(
      child: EasyLocalization(
        path: 'assets/translations',
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        fallbackLocale: const Locale('ar'),
        assetLoader: const CodegenLoader(),
        child: MyApp(),
      ),
    ));
  } else {
    runApp(const NoInternet());
  }
}

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();

  MyApp({super.key});

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
