import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';

abstract class RequestRepository {
  Future<Either<Failure, List<EventEntity>>> getAllRequests(String plannerId);
  Future<Either<Failure, String>> createRequest(
      EventEntity event, String token);
  Future<Either<Failure, String>> updateRequest(
      EventEntity event, String token);
  Future<Either<Failure, String>> cancelRequest(
      String id, String plannerId, String token);
}
