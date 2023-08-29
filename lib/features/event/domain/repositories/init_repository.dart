import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/init_entity.dart';

abstract class InitRepository {
  Future<Either<Failure, List<InitEntity>>> getAllInits(String plannerId);
  Future<Either<Failure, String>> createInit(InitEntity init, String token);
  Future<Either<Failure, String>> updateInit(InitEntity init, String token);
  Future<Either<Failure, String>> deleteInit(
      String initId, String plannerId, String token);
}
