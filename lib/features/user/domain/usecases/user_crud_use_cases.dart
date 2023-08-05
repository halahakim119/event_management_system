import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<Either<Failure, UserEntity>> getUser(String id) async {
    return repository.getUser(id);
  }
}

class DeleteUserUseCase {
  final UserRepository repository;

  DeleteUserUseCase(this.repository);

  Future<Either<Failure, String>> deleteUser(String id, String token) async {
    return repository.deleteUser(id, token);
  }
}

class EditUserUseCase {
  final UserRepository repository;

  EditUserUseCase(this.repository);

  Future<Either<Failure, Unit>> editUser(String id, String token, String name,
      String password, String province) async {
    return repository.editUser(id, token, name, password, province);
  }
}

class VerifyPhoneNumberUseCase {
  final UserRepository repository;

  VerifyPhoneNumberUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token) async {
    return repository.verifyPhoneNumber(id, number, token);
  }
}

class UpdatePhoneNumberUseCase {
  final UserRepository repository;

  UpdatePhoneNumberUseCase(this.repository);

  Future<Either<Failure, Unit>> updatePhoneNumber(
      String code, String verificationCode) async {
    return repository.updatePhoneNumber(code, verificationCode);
  }
}
