import 'router_imports.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: SplashRoute.page,
          initial: true,
        ),
        AutoRoute(page: LanguagesRoute.page),

        AutoRoute(page: AuthRoute.page),
        // AutoRoute(page: LoginRoute.page),
        // AutoRoute(page: SignupRoute.page),
        AutoRoute(page: VeificationRoute.page),
        AutoRoute(page: ForgotPasswordRoute.page),
        AutoRoute(page: ResetPasswordRoute.page),

        AutoRoute(page: MainRoute.page, children: [
          AutoRoute(page: HomeRoute.page),
          AutoRoute(page: ProfileRoute.page),
        ]),

        AutoRoute(page: SearchRoute.page),

        AutoRoute(page: SettingsRoute.page),
        AutoRoute(page: AboutUsRoute.page),
        AutoRoute(page: HelpCenterRoute.page),

        AutoRoute(page: EditProfileRoute.page),
        AutoRoute(page: EditNameProvinceRoute.page),

        AutoRoute(page: MyEventsRoute.page),
        AutoRoute(page: ServicesFormRoute.page),

        AutoRoute(page: DraftListRoute.page),
        AutoRoute(page: AddDraftRoute.page),
        AutoRoute(page: EditDraftRoute.page),

        AutoRoute(page: InvitationRoute.page),
        AutoRoute(page: FilterHostsRoute.page),
      ];
}
