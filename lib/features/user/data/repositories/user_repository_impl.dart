import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;

  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<Either<Failure, UserEntity>> getUser(String id) async {
    try {
      final result = await userDataSource.getUser(id);
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data.toEntity()),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to retrieve user data'));
    }
  }
}
