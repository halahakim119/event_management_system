import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../../domain/entities/init_entity.dart';

import '../../domain/repositories/init_repository.dart';

class InitRepositoryImpl implements InitRepository {
  @override
  Future<Either<Failure, String>> createInit(InitEntity init, String token) {
    // TODO: implement createInit
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> deleteInit(
      String initId, String plannerId, String token) {
    // TODO: implement deleteInit
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<InitEntity>>> getAllInits(String plannerId) {
    // TODO: implement getAllInits
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateInit(InitEntity init, String token) {
    // TODO: implement updateInit
    throw UnimplementedError();
  }
}
