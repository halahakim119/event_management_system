import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class ResetPassword {
  final AuthenticationRepository repository;

  ResetPassword(this.repository);

  Future<Either<Failure, Map<String, String>>> call({
    required String phoneNumber,
  }) async {
    final response = await repository.resetPassword(
      phoneNumber: phoneNumber,
    );
    return response.fold(
      (failure) => Left(failure),
      (map) => Right({
        'code': map['code']!,
        'verificationCode': map['verificationCode']!,
      }),
    );
  }
}
