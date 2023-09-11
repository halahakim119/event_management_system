import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/api_provider.dart';
import '../../../profile/data/models/user_profile_model.dart';
import '../../../user/domain/entities/user_entity.dart';

abstract class AuthenticationRemoteDataSource {
  Future<Either<Failure, Map<String, String>>> signUpWithPhone({
    required String name,
    required String province,
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, UserEntity>> signInWithPhone({
    required String phoneNumber,
    required String password,
  });

  Future<Either<Failure, Unit>> verifyPhoneSignUp({
    required String code,
    required String verificationCode,
  });

  Future<Either<Failure, Map<String, String>>> resetPassword(
      {required String phoneNumber});

  Future<Either<Failure, Unit>> verifyPhoneResetPassword({
    required String code,
    required String verificationCode,
    required String newPassword,
  });
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Box<UserProfileModel> _userBox;

  final ApiProvider _apiProvider;
  String? fcmToken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  AuthenticationRemoteDataSourceImpl(this._apiProvider, this._userBox);

  void requestNotificationPermissions() {
    _firebaseMessaging.requestPermission();
  }

  @override
  Future<Either<Failure, Map<String, String>>> signUpWithPhone({
    required String name,
    required String province,
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final response = await _apiProvider.post('user/signup/verify', {
        'name': name,
        'province': province,
        'number': phoneNumber,
        'password': password,
      });

      return Right({
        'code': response['code'],
        'verificationCode': response['verificationCode'],
      });
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneSignUp({
    required String code,
    required String verificationCode,
  }) async {
    try {
      await _apiProvider.post('user/signup/create', {
        'code': code,
        'verificationCode': verificationCode,
      });
      return const Right(unit);
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithPhone({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final String? fcmToken = await _firebaseMessaging.getToken();
      log(fcmToken!);
      final jsonResponse = await _apiProvider.post('user/login', {
        'number': phoneNumber,
        'password': password,
        'FCMtoken': fcmToken,
      });
      requestNotificationPermissions();

      final userJson = jsonResponse['user'] as Map<String, dynamic>;
      log(userJson.toString());
      final userData = UserProfileModel.fromJson(userJson);
      log(userData.toJson().toString());
      await _userBox.put('userBox', userData);

      return Right(userData.toEntity());
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, Map<String, String>>> resetPassword(
      {required String phoneNumber}) async {
    try {
      final response = await _apiProvider.post(
        'user/forgotPassword',
        {'number': phoneNumber},
      );

      return Right({
        'code': response['code'],
        'verificationCode': response['verificationCode'],
      });
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyPhoneResetPassword({
    required String code,
    required String verificationCode,
    required String newPassword,
  }) async {
    try {
      await http.put(
        Uri.parse('http://35.180.62.182/api/user/forgotPassword'),
        body: {
          'code': code,
          'verificationCode': verificationCode,
          'password': newPassword,
        },
      );

      return const Right(unit);
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
