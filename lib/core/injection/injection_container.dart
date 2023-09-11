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
import '../../features/profile/data/datasource/user_profile_data_source.dart';
import '../../features/profile/data/models/user_profile_model.dart';
import '../../features/profile/data/models/user_profile_model_adapter.dart';
import '../../features/profile/data/repositories/user_profile_repository_impl.dart';
import '../../features/profile/domain/repositories/user_profile_repository.dart';
import '../../features/profile/domain/usecases/user_crud_use_cases.dart';
import '../../features/profile/presentation/logic/bloc/user_profile_bloc.dart';
import '../../features/theme/data/theme_mode_adapter.dart';
import '../../features/theme/data/theme_repository.dart';
import '../../features/theme/domain/theme_interactor.dart';
import '../../features/theme/presentation/theme_cubit.dart';
import '../../features/user/data/datasource/user_data_source.dart';
import '../../features/user/data/models/user_model.dart';
import '../../features/user/data/models/user_model_adapter.dart';
import '../../features/user/data/repositories/user_repository_impl.dart';
import '../../features/user/domain/repositories/user_repository.dart';
import '../../features/user/domain/usecases/user_use_case.dart';
import '../../features/user/presentation/logic/bloc/user_bloc.dart';
import '../network/internet_checker.dart';
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
  Hive.registerAdapter<UserProfileModel>(UserProfileModelAdapter());
  Hive.registerAdapter<UserModel>(UserModelAdapter());
  Hive.registerAdapter<EventModel>(EventModelAdapter());

  // Open the Hive box
  Box<UserProfileModel> userBox;
  Box<UserModel> userDataBox;
  Box<EventModel> eventBox;
  Box themeBox;

  if (!Hive.isBoxOpen('themeBox')) {
    themeBox = await Hive.openBox('themeBox');
  } else {
    themeBox = Hive.box('themeBox');
  }

  if (!Hive.isBoxOpen('userBox')) {
    userBox = await Hive.openBox<UserProfileModel>('userBox');
  } else {
    userBox = Hive.box<UserProfileModel>('userBox');
  }

  if (!Hive.isBoxOpen('userDataBox')) {
    userDataBox = await Hive.openBox<UserModel>('userDataBox');
  } else {
    userDataBox = Hive.box<UserModel>('userDataBox');
  }

  if (!Hive.isBoxOpen('eventBox')) {
    eventBox = await Hive.openBox<EventModel>('eventBox');
  } else {
    eventBox = Hive.box<EventModel>('eventBox');
  }

  // Register Hive boxes
  sl.registerLazySingleton<Box<UserProfileModel>>(() => userBox);
  sl.registerLazySingleton<Box<UserModel>>(() => userDataBox);

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
      sl<Box<UserProfileModel>>(),
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

  //! user profile
  // Data sources
  sl.registerLazySingleton<UserProfileDataSource>(
      () => UserProfileDataSourceImpl(
            sl<Box<UserProfileModel>>(),
            sl<AuthenticationRemoteDataSource>(),
          ));

  // Repositories
  sl.registerLazySingleton<UserProfileRepository>(
    () => UserProfileRepositoryImpl(userDataSource: sl()),
  );

  // BLoC
  sl.registerFactory(() => UserProfileBloc(
        deleteUserUseCase: sl(),
        editUserUseCase: sl(),
        updatePhoneNumberUseCase: sl(),
        verifyPhoneNumberUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => EditUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberUseCase(sl()));

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

  // BLoC
  sl.registerFactory(() => UserBloc(
        getUserUseCase: sl(),
      ));

  //! event
  // Data sources
  sl.registerLazySingleton<EventRemoteDataSource>(
      () => EventRemoteDataSourceImpl(baseUrl: sl()));
  sl.registerLazySingleton<InitRemoteDataSource>(
      () => InitRemoteDataSourceImpl(baseUrl: sl()));
  sl.registerLazySingleton<RequestRemoteDataSource>(
      () => RequestRemoteDataSourceImpl(sl()));

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

  // BLoC

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
