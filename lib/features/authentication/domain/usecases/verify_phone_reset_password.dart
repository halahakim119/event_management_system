import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class VerifyPhoneResetPassword {
  final AuthenticationRepository repository;

  VerifyPhoneResetPassword(this.repository);

  Future<Either<Failure, Unit>> call({
    required String code,
    required String verificationCode,
    required String newPassword,
  }) async {
    final response = await repository.verifyPhoneResetPassword(
      code: code,
      verificationCode: verificationCode,
      newPassword: newPassword,
    );
    return response.fold(
      (failure) => Left(failure),
      (_) => const Right(unit),
    );
  }
}
