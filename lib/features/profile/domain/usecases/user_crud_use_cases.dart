import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/user_profile_repository.dart';

class DeleteUserUseCase {
  final UserProfileRepository repository;

  DeleteUserUseCase(this.repository);

  Future<Either<Failure, String>> deleteUser(String id, String token) async {
    return repository.deleteUser(id, token);
  }
}

class EditUserUseCase {
  final UserProfileRepository repository;

  EditUserUseCase(this.repository);

  Future<Either<Failure, String>> editUser(
      String id, String token, String name, String province) async {
    return repository.editUser(id, token, name, province);
  }
}

class VerifyPhoneNumberUseCase {
  final UserProfileRepository repository;

  VerifyPhoneNumberUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token) async {
    return repository.verifyPhoneNumber(id, number, token);
  }
}

class UpdatePhoneNumberUseCase {
  final UserProfileRepository repository;

  UpdatePhoneNumberUseCase(this.repository);

  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode) async {
    return repository.updatePhoneNumber(code, verificationCode);
  }
}
