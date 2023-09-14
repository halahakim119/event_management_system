import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';

abstract class RequestRepository {
  Future<Either<Failure, List<EventEntity>>> getAllRequests();
  Future<Either<Failure, String>> createRequest(EventEntity event);
  Future<Either<Failure, String>> updateRequest(EventEntity event);
  Future<Either<Failure, String>> cancelRequest(String id);
}
