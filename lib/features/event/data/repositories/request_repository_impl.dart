import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/event_entity.dart';
import '../../domain/repositories/request_repository.dart';
import '../datasources/request_remote_data_source.dart';
import '../models/event_model.dart';

class RequestRepositoryImpl implements RequestRepository {
  final RequestRemoteDataSource requestRemoteDataSource;

  RequestRepositoryImpl({
    required this.requestRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> createRequest(
      EventEntity event, String token) async {
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
        dressCode: event.dressCode,
      );

      final response =
          await requestRemoteDataSource.createRequest(eventModel, token);

      return response.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } on ServerException {
      return Left(ServerFailure('Failed to create request'));
    }
  }

  @override
  Future<Either<Failure, String>> cancelRequest(
      String id, String plannerId, String token) async {
    try {
      final result =
          await requestRemoteDataSource.cancelRequest(id, plannerId, token);

      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to cancel request'));
    }
  }

  @override
  Future<Either<Failure, List<EventEntity>>> getAllRequests(
      String plannerId) async {
    try {
      final result = await requestRemoteDataSource.getAllRequests(plannerId);

      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to get all requests'));
    }
  }

  @override
  Future<Either<Failure, String>> updateRequest(
      EventEntity event, String token) async {
    try {
      // Convert request entity to request model
      EventModel eventModel = EventModel(
        hostId: event.hostId!,
        id: event.id!,
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

      final result =
          await requestRemoteDataSource.updateRequest(eventModel, token);

      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to update request'));
    }
  }
}
