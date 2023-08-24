import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, List<EventEntity>>> getAllEvents(String plannerId);
  Future<Either<Failure, String>> updateEvent(EventEntity event, String token);
  Future<Either<Failure, String>> cancelEvent(EventEntity event, String token);
}
