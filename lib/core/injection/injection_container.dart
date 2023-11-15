import 'injection_imports.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Internet Checker
  sl.registerLazySingleton(() => InternetChecker());

  //! Hive
  // Initialize Hive
  await Hive.initFlutter();

  // Register Hive Adapters
  Hive.registerAdapter(ThemeModeAdapter());
  Hive.registerAdapter<UserModel>(UserModelAdapter());

  // Open the Hive box
  Box<UserModel> userBox;

  Box themeBox;

  if (!Hive.isBoxOpen('themeBox')) {
    themeBox = await Hive.openBox('themeBox');
  } else {
    themeBox = Hive.box('themeBox');
  }

  if (!Hive.isBoxOpen('userBox')) {
    userBox = await Hive.openBox<UserModel>('userBox');
  } else {
    userBox = Hive.box<UserModel>('userBox');
  }

  // Register Hive boxes
  sl.registerLazySingleton<Box<UserModel>>(() => userBox);

  // Register Theme-related components
  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(themeBox));
  sl.registerLazySingleton<ThemeInteractor>(
      () => ThemeInteractorImpl(sl<ThemeRepository>()));
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl<ThemeInteractor>()));

  //! API Provider
  sl.registerLazySingleton<ApiProvider>(() => ApiProvider());

  //! Authentication
  // Data sources
  sl.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(
      sl<ApiProvider>(),
      sl<Box<UserModel>>(),
    ),
  );

  // Repositories
  sl.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(remoteDataSource: sl()),
  );

  // BLoC
  sl.registerFactory(
    () => AuthenticationBloc(
      signUpWithPhone: sl(),
      signInWithPhone: sl(),
      verifyPhoneSignUp: sl(),
      resetPassword: sl(),
      verifyPhoneResetPassword: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SignUpWithPhone(sl()));
  sl.registerLazySingleton(() => SignInWithPhone(sl()));
  sl.registerLazySingleton(() => VerifyPhoneSignUp(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => VerifyPhoneResetPassword(sl()));

  //! user
  // Data sources
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(
        userBox: sl<Box<UserModel>>(),
      ));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => EditUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberUseCase(sl()));

  // BLoC
  sl.registerFactory(() => UserBloc(
        getUserUseCase: sl(),
        deleteUserUseCase: sl(),
        editUserUseCase: sl(),
        updatePhoneNumberUseCase: sl(),
        verifyPhoneNumberUseCase: sl(),
      ));

  //! invitations
  // Data sources
  sl.registerLazySingleton<InvitationsRemoteDataSource>(
      () => InvitationsRemoteDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<InvitationsRepository>(
    () => InvitationsRepositoryImpl(invitationsRemoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetAllInvitationsUseCase(sl()));

  // BLoC
  sl.registerFactory(() => InvitationsCubit(sl()));

  //! host
  // Data sources
  sl.registerLazySingleton<HostRemoteDataSource>(
      () => HostRemoteDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<HostRepository>(
    () => HostRepositoryImpl(hostRemoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => FilterHostsUseCase(sl()));

  // BLoC
  sl.registerFactory(() => HostsCubit(sl()));

  //! event

  sl.registerLazySingleton<EventRemoteDataSource>(
      () => EventRemoteDataSourceImpl(baseUrl: baseUrl));

  // Repositories
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(eventRemoteDataSource: sl()),
  );

  // Cubit

  sl.registerFactory(() => EventCubit(
        createEventUseCase: sl(),
        deleteEventUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => CreateEventUseCase(sl()));
  sl.registerLazySingleton(() => DeleteEventUseCase(sl()));
}
