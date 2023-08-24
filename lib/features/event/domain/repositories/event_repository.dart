import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';
import '../entities/init_entity.dart';
import '../entities/request_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, List<InitEntity>>> getAllInits(String plannerId);
  Future<Either<Failure, String>> createInit(InitEntity init, String token);
  Future<Either<Failure, String>> updateInit(InitEntity init, String token);
  Future<Either<Failure, String>> deleteInit(
      String initId, String plannerId, String token);

  Future<Either<Failure, List<RequestEntity>>> getAllRequests(String plannerId);
  Future<Either<Failure, String>> createRequest(
      InitEntity init, String token, String hostId);
  Future<Either<Failure, String>> updateRequest(
      RequestEntity request, String token);
  Future<Either<Failure, String>> cancelRequest(
      String requestId, String plannerId, String token);

  Future<Either<Failure, List<EventEntity>>> getAllEvents(String plannerId);
  Future<Either<Failure, String>> updateEvent(EventEntity event, String token);
  Future<Either<Failure, String>> cancelEvent(EventEntity event, String token);
}
