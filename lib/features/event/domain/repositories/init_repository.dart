import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';

abstract class InitRepository {
  Future<Either<Failure, List<EventEntity>>> getAllInits();
  Future<Either<Failure, String>> createInit(EventEntity event);
  Future<Either<Failure, String>> updateInit(EventEntity event);
  Future<Either<Failure, String>> deleteInit(String id);
}
