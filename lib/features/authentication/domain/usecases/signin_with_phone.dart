import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../user/domain/entities/user_entity.dart';


import '../repositories/authentication_repository.dart';

class SignInWithPhone {
  final AuthenticationRepository repository;

  SignInWithPhone(this.repository);

  Future<Either<Failure, UserEntity>> call({
    required String phoneNumber,
    required String password,
  }) async {
    final response = await repository.signInWithPhone(
      phoneNumber: phoneNumber,
      password: password,
    );
    return response.fold(
      (failure) => Left(failure),
      (userEntity) => Right(userEntity),
    );
  }
}
