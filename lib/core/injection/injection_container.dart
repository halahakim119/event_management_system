import '../../features/profile/data/datasource/user_data_source.dart';

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
import '../../features/profile/data/models/user_profile_model.dart';
import '../../features/profile/data/models/user_profile_model_adapter.dart';
import '../../features/profile/data/repositories/user_repository_impl.dart';
import '../../features/profile/domain/repositories/user_repository.dart';
import '../../features/profile/domain/usecases/user_crud_use_cases.dart';
import '../../features/profile/presentation/logic/bloc/user_bloc.dart';
import '../../features/theme/data/theme_mode_adapter.dart';
import '../../features/theme/data/theme_repository.dart';
import '../../features/theme/domain/theme_interactor.dart';
import '../../features/theme/presentation/theme_cubit.dart';

import '../utils/api_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Initialize Hive
  await Hive.initFlutter();

  //! Register Hive Adapters
  Hive.registerAdapter(ThemeModeAdapter());

  //! Open the Hive box
  final themeBox = await Hive.openBox('themeBox');

  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(themeBox));
  sl.registerLazySingleton<ThemeInteractor>(
      () => ThemeInteractorImpl(sl<ThemeRepository>()));
  sl.registerFactory<ThemeCubit>(() => ThemeCubit(sl<ThemeInteractor>()));

//! Register Hive Adapters

  Hive.registerAdapter<UserProfileModel>(UserProfileModelAdapter());

  //! Open the Hive box
  Box<UserProfileModel> userBox;
  if (!Hive.isBoxOpen('userBox')) {
    userBox = await Hive.openBox<UserProfileModel>('userBox');
  } else {
    userBox = Hive.box<UserProfileModel>('userBox');
  }

  sl.registerLazySingleton<Box<UserProfileModel>>(() => userBox);

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

  //! user
  // Data sources
  sl.registerLazySingleton<UserDataSource>(() => UserDataSourceImpl(
        sl<Box<UserProfileModel>>(),
        sl<AuthenticationRemoteDataSource>(),
      ));

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userDataSource: sl()),
  );

  // BLoC
  sl.registerFactory(() => UserBloc(
        deleteUserUseCase: sl(),
        editUserUseCase: sl(),
        getUserUseCase: sl(),
        updatePhoneNumberUseCase: sl(),
        verifyPhoneNumberUseCase: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => EditUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePhoneNumberUseCase(sl()));
  sl.registerLazySingleton(() => VerifyPhoneNumberUseCase(sl()));
}
