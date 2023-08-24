import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../../domain/entities/event_entity.dart';

import '../../domain/repositories/event_repository.dart';

class EventRepositoryImpl implements EventRepository {
  @override
  Future<Either<Failure, String>> cancelEvent(EventEntity event, String token) {
    // TODO: implement cancelEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents(String plannerId) {
    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateEvent(EventEntity event, String token) {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }
}
