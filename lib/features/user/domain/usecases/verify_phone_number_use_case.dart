import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/user_repository.dart';

class VerifyPhoneNumberUseCase {
  final UserRepository repository;

  VerifyPhoneNumberUseCase(this.repository);

  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token) async {
    return repository.verifyPhoneNumber(id, number, token);
  }
}
