import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/user_repository.dart';

class UpdatePhoneNumberUseCase {
  final UserRepository repository;

  UpdatePhoneNumberUseCase(this.repository);

  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode) async {
    return repository.updatePhoneNumber(code, verificationCode);
  }
}
