// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AboutUsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutUsScreen(),
      );
    },
    AddDraftRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AddDraftScreen(),
      );
    },
    AuthRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AuthScreen(),
      );
    },
    DraftListRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DraftListScreen(),
      );
    },
    EditDraftRoute.name: (routeData) {
      final args = routeData.argsAs<EditDraftRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditDraftScreen(
          key: args.key,
          draft: args.draft,
        ),
      );
    },
    EditNameProvinceRoute.name: (routeData) {
      final args = routeData.argsAs<EditNameProvinceRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditNameProvinceScreen(
          key: args.key,
          user: args.user,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const EditProfileScreen(),
      );
    },
    FilterHostsRoute.name: (routeData) {
      final args = routeData.argsAs<FilterHostsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FilterHostsScreen(
          key: args.key,
          event: args.event,
        ),
      );
    },
    ForgotPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ForgotPasswordRouteArgs>(
          orElse: () => const ForgotPasswordRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ForgotPasswordScreen(key: args.key),
      );
    },
    HelpCenterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HelpCenterScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    InvitationRoute.name: (routeData) {
      final args = routeData.argsAs<InvitationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvitationScreen(
          key: args.key,
          draft: args.draft,
          isEdit: args.isEdit,
        ),
      );
    },
    LanguagesRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LanguagesScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LoginScreen(),
      );
    },
    MainRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MainScreen(),
      );
    },
    MyEventsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const MyEventsScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfileScreen(),
      );
    },
    ResetPasswordRoute.name: (routeData) {
      final args = routeData.argsAs<ResetPasswordRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ResetPasswordScreen(
          key: args.key,
          verificationCode: args.verificationCode,
          code: args.code,
        ),
      );
    },
    SearchRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SearchScreen(),
      );
    },
    ServicesFormRoute.name: (routeData) {
      final args = routeData.argsAs<ServicesFormRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ServicesFormScreen(
          key: args.key,
          event: args.event,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SettingsScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SignupScreen(),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    VeificationRoute.name: (routeData) {
      final args = routeData.argsAs<VeificationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: VeificationScreen(
          key: args.key,
          code: args.code,
          verificationCode: args.verificationCode,
          typeForm: args.typeForm,
        ),
      );
    },
  };
}

/// generated route for
/// [AboutUsScreen]
class AboutUsRoute extends PageRouteInfo<void> {
  const AboutUsRoute({List<PageRouteInfo>? children})
      : super(
          AboutUsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutUsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AddDraftScreen]
class AddDraftRoute extends PageRouteInfo<void> {
  const AddDraftRoute({List<PageRouteInfo>? children})
      : super(
          AddDraftRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddDraftRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [AuthScreen]
class AuthRoute extends PageRouteInfo<void> {
  const AuthRoute({List<PageRouteInfo>? children})
      : super(
          AuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DraftListScreen]
class DraftListRoute extends PageRouteInfo<void> {
  const DraftListRoute({List<PageRouteInfo>? children})
      : super(
          DraftListRoute.name,
          initialChildren: children,
        );

  static const String name = 'DraftListRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditDraftScreen]
class EditDraftRoute extends PageRouteInfo<EditDraftRouteArgs> {
  EditDraftRoute({
    Key? key,
    required Draft draft,
    List<PageRouteInfo>? children,
  }) : super(
          EditDraftRoute.name,
          args: EditDraftRouteArgs(
            key: key,
            draft: draft,
          ),
          initialChildren: children,
        );

  static const String name = 'EditDraftRoute';

  static const PageInfo<EditDraftRouteArgs> page =
      PageInfo<EditDraftRouteArgs>(name);
}

class EditDraftRouteArgs {
  const EditDraftRouteArgs({
    this.key,
    required this.draft,
  });

  final Key? key;

  final Draft draft;

  @override
  String toString() {
    return 'EditDraftRouteArgs{key: $key, draft: $draft}';
  }
}

/// generated route for
/// [EditNameProvinceScreen]
class EditNameProvinceRoute extends PageRouteInfo<EditNameProvinceRouteArgs> {
  EditNameProvinceRoute({
    Key? key,
    required UserModel user,
    List<PageRouteInfo>? children,
  }) : super(
          EditNameProvinceRoute.name,
          args: EditNameProvinceRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'EditNameProvinceRoute';

  static const PageInfo<EditNameProvinceRouteArgs> page =
      PageInfo<EditNameProvinceRouteArgs>(name);
}

class EditNameProvinceRouteArgs {
  const EditNameProvinceRouteArgs({
    this.key,
    required this.user,
  });

  final Key? key;

  final UserModel user;

  @override
  String toString() {
    return 'EditNameProvinceRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [EditProfileScreen]
class EditProfileRoute extends PageRouteInfo<void> {
  const EditProfileRoute({List<PageRouteInfo>? children})
      : super(
          EditProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FilterHostsScreen]
class FilterHostsRoute extends PageRouteInfo<FilterHostsRouteArgs> {
  FilterHostsRoute({
    Key? key,
    required EventEntity event,
    List<PageRouteInfo>? children,
  }) : super(
          FilterHostsRoute.name,
          args: FilterHostsRouteArgs(
            key: key,
            event: event,
          ),
          initialChildren: children,
        );

  static const String name = 'FilterHostsRoute';

  static const PageInfo<FilterHostsRouteArgs> page =
      PageInfo<FilterHostsRouteArgs>(name);
}

class FilterHostsRouteArgs {
  const FilterHostsRouteArgs({
    this.key,
    required this.event,
  });

  final Key? key;

  final EventEntity event;

  @override
  String toString() {
    return 'FilterHostsRouteArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [ForgotPasswordScreen]
class ForgotPasswordRoute extends PageRouteInfo<ForgotPasswordRouteArgs> {
  ForgotPasswordRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ForgotPasswordRoute.name,
          args: ForgotPasswordRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const PageInfo<ForgotPasswordRouteArgs> page =
      PageInfo<ForgotPasswordRouteArgs>(name);
}

class ForgotPasswordRouteArgs {
  const ForgotPasswordRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ForgotPasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [HelpCenterScreen]
class HelpCenterRoute extends PageRouteInfo<void> {
  const HelpCenterRoute({List<PageRouteInfo>? children})
      : super(
          HelpCenterRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpCenterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [InvitationScreen]
class InvitationRoute extends PageRouteInfo<InvitationRouteArgs> {
  InvitationRoute({
    Key? key,
    required Draft draft,
    bool? isEdit,
    List<PageRouteInfo>? children,
  }) : super(
          InvitationRoute.name,
          args: InvitationRouteArgs(
            key: key,
            draft: draft,
            isEdit: isEdit,
          ),
          initialChildren: children,
        );

  static const String name = 'InvitationRoute';

  static const PageInfo<InvitationRouteArgs> page =
      PageInfo<InvitationRouteArgs>(name);
}

class InvitationRouteArgs {
  const InvitationRouteArgs({
    this.key,
    required this.draft,
    this.isEdit,
  });

  final Key? key;

  final Draft draft;

  final bool? isEdit;

  @override
  String toString() {
    return 'InvitationRouteArgs{key: $key, draft: $draft, isEdit: $isEdit}';
  }
}

/// generated route for
/// [LanguagesScreen]
class LanguagesRoute extends PageRouteInfo<void> {
  const LanguagesRoute({List<PageRouteInfo>? children})
      : super(
          LanguagesRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguagesRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MainScreen]
class MainRoute extends PageRouteInfo<void> {
  const MainRoute({List<PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MyEventsScreen]
class MyEventsRoute extends PageRouteInfo<void> {
  const MyEventsRoute({List<PageRouteInfo>? children})
      : super(
          MyEventsRoute.name,
          initialChildren: children,
        );

  static const String name = 'MyEventsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ProfileScreen]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ResetPasswordScreen]
class ResetPasswordRoute extends PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    Key? key,
    required String verificationCode,
    required String code,
    List<PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(
            key: key,
            verificationCode: verificationCode,
            code: code,
          ),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static const PageInfo<ResetPasswordRouteArgs> page =
      PageInfo<ResetPasswordRouteArgs>(name);
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({
    this.key,
    required this.verificationCode,
    required this.code,
  });

  final Key? key;

  final String verificationCode;

  final String code;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key, verificationCode: $verificationCode, code: $code}';
  }
}

/// generated route for
/// [SearchScreen]
class SearchRoute extends PageRouteInfo<void> {
  const SearchRoute({List<PageRouteInfo>? children})
      : super(
          SearchRoute.name,
          initialChildren: children,
        );

  static const String name = 'SearchRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ServicesFormScreen]
class ServicesFormRoute extends PageRouteInfo<ServicesFormRouteArgs> {
  ServicesFormRoute({
    Key? key,
    required EventEntity event,
    List<PageRouteInfo>? children,
  }) : super(
          ServicesFormRoute.name,
          args: ServicesFormRouteArgs(
            key: key,
            event: event,
          ),
          initialChildren: children,
        );

  static const String name = 'ServicesFormRoute';

  static const PageInfo<ServicesFormRouteArgs> page =
      PageInfo<ServicesFormRouteArgs>(name);
}

class ServicesFormRouteArgs {
  const ServicesFormRouteArgs({
    this.key,
    required this.event,
  });

  final Key? key;

  final EventEntity event;

  @override
  String toString() {
    return 'ServicesFormRouteArgs{key: $key, event: $event}';
  }
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SignupScreen]
class SignupRoute extends PageRouteInfo<void> {
  const SignupRoute({List<PageRouteInfo>? children})
      : super(
          SignupRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [VeificationScreen]
class VeificationRoute extends PageRouteInfo<VeificationRouteArgs> {
  VeificationRoute({
    Key? key,
    required String code,
    required String verificationCode,
    String? typeForm,
    List<PageRouteInfo>? children,
  }) : super(
          VeificationRoute.name,
          args: VeificationRouteArgs(
            key: key,
            code: code,
            verificationCode: verificationCode,
            typeForm: typeForm,
          ),
          initialChildren: children,
        );

  static const String name = 'VeificationRoute';

  static const PageInfo<VeificationRouteArgs> page =
      PageInfo<VeificationRouteArgs>(name);
}

class VeificationRouteArgs {
  const VeificationRouteArgs({
    this.key,
    required this.code,
    required this.verificationCode,
    this.typeForm,
  });

  final Key? key;

  final String code;

  final String verificationCode;

  final String? typeForm;

  @override
  String toString() {
    return 'VeificationRouteArgs{key: $key, code: $code, verificationCode: $verificationCode, typeForm: $typeForm}';
  }
}
