import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class VerifyPhoneSignUp {
  final AuthenticationRepository repository;

  VerifyPhoneSignUp(this.repository);

  Future<Either<Failure, Unit>> call({
    required String code,
    required String verificationCode,
  }) async {
    final response = await repository.verifyPhoneSignUp(
      code: code,
      verificationCode: verificationCode,
    );
    return response.fold(
      (failure) => Left(failure),
      (_) => const Right(unit),
    );
  }
}
