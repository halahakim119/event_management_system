import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_remote_data_source.dart';
import '../models/event_model.dart';

class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource eventRemoteDataSource;

  EventRepositoryImpl({
    required this.eventRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> cancelEvent(
      EventEntity event, String token) async {
    try {
      EventModel eventModel = EventModel(
        hostId: event.hostId!,
        id: event.id,
        guests: event.guests,
        plannerId: event.plannerId,
        guestsNumber: event.guestsNumber,
        startsAt: event.startsAt,
        endsAt: event.endsAt,
        description: event.description,
        type: event.type,
        postType: event.postType,
        title: event.title,
        startingDate: event.startingDate,
        endingDate: event.endingDate,
        adultsOnly: event.adultsOnly,
        food: event.food,
        alcohol: event.alcohol,
        dressCode: event.dressCode,
      );

      final result = await eventRemoteDataSource.cancelEvent(eventModel, token);

      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to cancel event'));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getAllEvents(
      String plannerId) async {
    try {
      final result = await eventRemoteDataSource.getAllEvents(plannerId);

      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to get all events'));
    }
  }

  @override
  Future<Either<Failure, String>> updateEvent(
      EventEntity event, String token) async {
    try {
      EventModel eventModel = EventModel(
        hostId: event.hostId!,
        id: event.id,
        guests: event.guests,
        plannerId: event.plannerId,
        guestsNumber: event.guestsNumber,
        startsAt: event.startsAt,
        endsAt: event.endsAt,
        description: event.description,
        type: event.type,
        postType: event.postType,
        title: event.title,
        startingDate: event.startingDate,
        endingDate: event.endingDate,
        adultsOnly: event.adultsOnly,
        food: event.food,
        alcohol: event.alcohol,
        dressCode: event.dressCode,
      );

      final result = await eventRemoteDataSource.updateEvent(eventModel, token);

      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to update event'));
    }
  }
}
