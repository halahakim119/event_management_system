import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../features/authentication/presentation/view/pages/auth_screen.dart';
import '../../features/authentication/presentation/view/pages/forgot_password_screen.dart';
import '../../features/authentication/presentation/view/pages/login_screen.dart';
import '../../features/authentication/presentation/view/pages/reset_password_screen.dart';
import '../../features/authentication/presentation/view/pages/signup_screen.dart';
import '../../features/authentication/presentation/view/pages/verification_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/languages/pages/languages_screen.dart';
import '../../features/main/main_screen.dart';
import '../../features/search and filter/search_screen.dart';
import '../../features/settings/about_us_screen.dart';
import '../../features/settings/help_center_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/user/presentation/view/pages/edit_profile_screen.dart';
import '../../features/user/presentation/view/pages/profile_screen.dart';

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
          AutoRoute(page: ProfileRoute.page),
        ]),
        AutoRoute(page: LanguagesRoute.page),
        AutoRoute(page: AuthRoute.page),
        AutoRoute(page: SearchRoute.page),
        // AutoRoute(page: LoginRoute.page),
        // AutoRoute(page: SignupRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),
        AutoRoute(page: VeificationRoute.page),

        AutoRoute(page: EditProfileRoute.page),

        AutoRoute(page: AboutUsRoute.page),
        AutoRoute(page: HelpCenterRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ];
}
