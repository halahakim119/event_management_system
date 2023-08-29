import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class UserProfileRepository {
  Future<Either<Failure, String>> deleteUser(String id, String token);
  Future<Either<Failure, String>> editUser(
      String id, String token, String name, String province);

  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token);
  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode);
}
