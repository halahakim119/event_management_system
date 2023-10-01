import 'package:dartz/dartz.dart';
import 'package:event_management_system/features/event/data/datasources/event_local_data_source.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/init_repository.dart';
import '../datasources/init_remote_data_source.dart';
import '../models/event_model.dart';

class InitRepositoryImpl implements InitRepository {
  final InitRemoteDataSource initRemoteDataSource;
  EventLocalDataSource eventLocalDataSource;
  InitRepositoryImpl({
    required this.initRemoteDataSource,
    required this.eventLocalDataSource
  });

  @override
  Future<Either<Failure, String>> createInit(EventEntity event) async {
    try {
      EventModel eventModel = EventModel(
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
          dressCode: event.dressCode);
      final response = await eventLocalDataSource.addDraft(eventModel);
      return response.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } on ServerException {
      return Left(ServerFailure('failed to create'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteInit(String id) async {
    try {
      final result = await initRemoteDataSource.deleteInit(id);
      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to delete'));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getAllInits() async {
    try {
      final result = await eventLocalDataSource.getAllDrafts();
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to get all data'));
    }
  }

  @override
  Future<Either<Failure, String>> updateInit(EventEntity event) async {
    try {
      EventModel eventModel = EventModel(
          id: event.id,
          guestsNumbers: event.guestsNumbers,
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
          dressCode: event.dressCode);
      final result = await initRemoteDataSource.updateInit(eventModel);
      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to get all data'));
    }
  }
}
