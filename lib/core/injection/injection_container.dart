import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../features/authentication/data/datasources/authentication_remote_data_source.dart';
import '../../features/authentication/data/repositories/authentication_repository_impl.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import '../../features/authentication/domain/usecases/reset_password.dart';
import '../../features/authentication/domain/usecases/signin_with_phone.dart';
import '../../features/authentication/domain/usecases/signup_with_phone.dart';
import '../../features/authentication/domain/usecases/verify_phone_reset_password.dart';
import '../../features/authentication/domain/usecases/verify_phone_signup.dart';
import '../../features/authentication/presentation/logic/bloc/authentication_bloc.dart';
import '../../features/event/data/datasources/event_remote_data_source.dart';
import '../../features/event/data/datasources/init_remote_data_source.dart';
import '../../features/event/data/datasources/request_remote_data_source.dart';
import '../../features/event/data/models/event_model.dart';
import '../../features/event/data/models/event_model_adapter.dart';
import '../../features/event/data/repositories/event_repository_impl.dart';
import '../../features/event/data/repositories/init_repository_impl.dart';
import '../../features/event/data/repositories/request_repository_impl.dart';
import '../../features/event/domain/repositories/event_repository.dart';
import '../../features/event/domain/repositories/init_repository.dart';
import '../../features/event/domain/repositories/request_repository.dart';
import '../../features/event/domain/usecases/event/cancel_event_usecase.dart';
import '../../features/event/domain/usecases/event/get_all_events_usecase.dart';
import '../../features/event/domain/usecases/event/update_event_usecase.dart';
import '../../features/event/domain/usecases/init/create_init_usecase.dart';
import '../../features/event/domain/usecases/init/delete_init_usecase.dart';
import '../../features/event/domain/usecases/init/get_all_inits_usecase.dart';
import '../../features/event/domain/usecases/init/update_init_usecase.dart';
import '../../features/event/domain/usecases/request/cancel_request_usecase.dart';
import '../../features/event/domain/usecases/request/create_request_usecase.dart';
import '../../features/event/domain/usecases/request/get_all_requests_usecase.dart';
import '../../features/event/domain/usecases/request/update_request_usecase.dart';
import '../../features/event/presentation/logic/cubit/event_cubit.dart';
import '../../features/event/presentation/logic/cubit/init_cubit.dart';
import '../../features/event/presentation/logic/cubit/request_cubit.dart';
import '../../features/host/data/datasources/host_remote_data_source.dart';
import '../../features/host/data/repositories/host_repository_impl.dart';
import '../../features/host/domain/repositories/host_repository.dart';
import '../../features/host/domain/usecases/filter_hosts_use_case.dart';
import '../../features/host/presentation/logic/cubit/hosts_cubit.dart';
import '../../features/invitaions/data/datasources/invitations_data_source.dart';
import '../../features/invitaions/data/repositories/invitations_repository_impl.dart';
import '../../features/invitaions/domain/repositories/invitations_repository.dart';
import '../../features/invitaions/domain/usecases/get_users_use_case.dart';
import '../../features/invitaions/presentation/logic/cubit/invitations_cubit.dart';
import '../../features/theme/data/theme_mode_adapter.dart';
import '../../features/theme/data/theme_repository.dart';
import '../../features/theme/domain/theme_interactor.dart';
import '../../features/theme/presentation/theme_cubit.dart';
import '../../features/user/data/datasource/user_data_source.dart';
import '../../features/user/data/models/user_model.dart';
import '../../features/user/data/models/user_model_adapter.dart';
import '../../features/user/data/repositories/user_repository_impl.dart';
import '../../features/user/domain/repositories/user_repository.dart';
import '../../features/user/domain/usecases/delete_user_use_case.dart';
import '../../features/user/domain/usecases/edit_user_use_case.dart';
import '../../features/user/domain/usecases/get_user_use_case.dart';
import '../../features/user/domain/usecases/update_phone_number_use_case.dart';
import '../../features/user/domain/usecases/verify_phone_number_use_case.dart';
import '../../features/user/presentation/logic/bloc/user_bloc.dart';
import '../network/internet_checker.dart';
import '../strings/strings.dart';
import '../utils/api_provider.dart';

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
  Hive.registerAdapter<EventModel>(EventModelAdapter());

  // Open the Hive box
  Box<UserModel> userBox;
  Box<EventModel> eventBox;
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

  if (!Hive.isBoxOpen('eventBox')) {
    eventBox = await Hive.openBox<EventModel>('eventBox');
  } else {
    eventBox = Hive.box<EventModel>('eventBox');
  }

  // Check if the user is logged in and get user data
  final UserModel? userModel =
      UserModel.getUserData(); // Replace with your login logic

  // Register Hive boxes
  sl.registerLazySingleton<Box<UserModel>>(() => userBox);
  sl.registerLazySingleton<Box<EventModel>>(() => eventBox);

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
  // Data sources

  sl.registerLazySingleton<EventRemoteDataSource>(
      () => EventRemoteDataSourceImpl(baseUrl: baseUrl, user: userModel));
  sl.registerLazySingleton<InitRemoteDataSource>(() => InitRemoteDataSourceImpl(
      baseUrl: baseUrl, user: userModel, userBox: userBox));
  sl.registerLazySingleton<RequestRemoteDataSource>(
      () => RequestRemoteDataSourceImpl(baseUrl: baseUrl, user: userModel));

  // Repositories
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(eventRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<InitRepository>(
    () => InitRepositoryImpl(initRemoteDataSource: sl()),
  );
  sl.registerLazySingleton<RequestRepository>(
    () => RequestRepositoryImpl(requestRemoteDataSource: sl()),
  );

  // Cubit
  sl.registerFactory(() => InitCubit(
      getAllInitsUseCase: sl(),
      createInitUseCase: sl(),
      deleteInitUseCase: sl(),
      updateInitUseCase: sl()));

  sl.registerFactory(() => RequestCubit(
      getAllRequestsUseCase: sl(),
      createRequestUseCase: sl(),
      updateRequestUseCase: sl(),
      cancelRequestUseCase: sl()));

  sl.registerFactory(() => EventCubit(
      getAllEventsUseCase: sl(),
      cancelEventUseCase: sl(),
      updateEventUseCase: sl()));

  // Use cases
  sl.registerLazySingleton(() => CreateInitUseCase(sl()));
  sl.registerLazySingleton(() => DeleteInitUseCase(sl()));
  sl.registerLazySingleton(() => GetAllInitsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateInitUseCase(sl()));

  sl.registerLazySingleton(() => CancelRequestUseCase(sl()));
  sl.registerLazySingleton(() => GetAllRequestsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateRequestUseCase(sl()));
  sl.registerLazySingleton(() => CreateRequestUseCase(sl()));

  sl.registerLazySingleton(() => CancelEventUseCase(sl()));
  sl.registerLazySingleton(() => GetAllEventsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateEventUseCase(sl()));
}
