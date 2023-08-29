import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../user/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
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

  Future<Either<Failure, Map<String, String>>> resetPassword({
    required String phoneNumber,
  });

  Future<Either<Failure, Unit>> verifyPhoneResetPassword({
    required String code,
    required String verificationCode,
    required String newPassword,
  });
}
