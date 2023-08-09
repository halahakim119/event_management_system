import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, String>> deleteUser(String id, String token);
  Future<Either<Failure, Unit>> editUser(
      String id, String token, String name, String province);
  Future<Either<Failure, UserEntity>> getUser(String id);
  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token);
  Future<Either<Failure, Unit>> updatePhoneNumber(
      String code, String verificationCode);
}
