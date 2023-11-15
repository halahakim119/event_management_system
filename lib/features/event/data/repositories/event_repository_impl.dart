import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
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
  Future<Either<Failure, String>> create(EventEntity event) async {
    try {
      EventModel eventModel = EventModel(
        
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
          guestsNumbers: event.guestsNumbers,
          alcohol: event.alcohol,
          id: event.id,
          confirmedGuests: event.confirmedGuests,
          guests: event.guests,
          host: event.host,
          hostRejected: event.hostRejected,
          dressCode: event.dressCode);
      final response = await eventRemoteDataSource.create(eventModel);
      return response.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } on ServerException {
      return Left(ServerFailure('failed to create'));
    }
  }

  @override
  Future<Either<Failure, String>> delete(String id) async {
    try {
      final result = await eventRemoteDataSource.delete(id);
      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to delete'));
    }
  }
}
