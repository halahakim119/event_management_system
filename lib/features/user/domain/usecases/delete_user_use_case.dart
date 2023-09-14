import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/user_repository.dart';

class DeleteUserUseCase {
  final UserRepository repository;

  DeleteUserUseCase(this.repository);

  Future<Either<Failure, String>> deleteUser(String id, String token) async {
    return repository.deleteUser(id, token);
  }
}
