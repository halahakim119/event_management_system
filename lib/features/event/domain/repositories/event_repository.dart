import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';
import '../entities/init_entity.dart';
import '../entities/request_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, InitEntity>> createInit(InitEntity init);
  Future<Either<Failure, InitEntity>> updateInit(InitEntity init);
  Future<Either<Failure, bool>> deleteInit(String initId, String plannerId);

  Future<Either<Failure, RequestEntity>> createRequest(RequestEntity request);
  Future<Either<Failure, RequestEntity>> updateRequest(RequestEntity request);
  Future<Either<Failure, bool>> cancelRequest(
      String requestId, String plannerId);

  Future<Either<Failure, EventEntity>> createEvent(EventEntity event);
  Future<Either<Failure, EventEntity>> updateEvent(EventEntity event);
  Future<Either<Failure, bool>> cancelEvent(String eventId, String plannerId);
}
