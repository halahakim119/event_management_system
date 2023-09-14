import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/user_repository.dart';

class EditUserUseCase {
  final UserRepository repository;

  EditUserUseCase(this.repository);

  Future<Either<Failure, String>> editUser(
      String id, String token, String name, String province) async {
    return repository.editUser(id, token, name, province);
  }
}
