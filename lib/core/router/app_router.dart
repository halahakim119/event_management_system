import 'package:auto_route/auto_route.dart';

import '../../features/home/home_screen.dart';
import '../../features/main/main_screen.dart';
import '../../features/splash/splash_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: HomeRoute.page),
          
        ]),
      ];
}
