import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/repositories/user_profile_repository.dart';
import '../datasource/user_profile_data_source.dart';

class UserProfileRepositoryImpl implements UserProfileRepository {
  final UserProfileDataSource userDataSource;

  UserProfileRepositoryImpl({required this.userDataSource});

  @override
  Future<Either<Failure, String>> deleteUser(String id, String token) async {
    try {
      final result = await userDataSource.deleteUser(id, token);
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to delete user'));
    }
  }

  @override
  Future<Either<Failure, String>> editUser(
      String id, String token, String name, String province) async {
    try {
      final result = await userDataSource.editUser(id, token, name, province);
      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to update user name'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token) async {
    try {
      final result = await userDataSource.verifyPhoneNumber(id, number, token);
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to verify phone number'));
    }
  }

  @override
  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode) async {
    try {
      final result =
          await userDataSource.updatePhoneNumber(code, verificationCode);
      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to update phone number'));
    }
  }
}
