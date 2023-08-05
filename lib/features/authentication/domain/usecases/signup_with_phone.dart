import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/authentication_repository.dart';

class SignUpWithPhone {
  final AuthenticationRepository repository;

  SignUpWithPhone(this.repository);

  Future<Either<Failure, Map<String, String>>> call({
    required String name,
    required String province,
    required String phoneNumber,
    required String password,
  }) async {
    final response = await repository.signUpWithPhone(
      name: name,
      province: province,
      phoneNumber: phoneNumber,
      password: password,
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
