import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/init_entity.dart';
import '../../domain/entities/request_entity.dart';
import '../../domain/repositories/request_repository.dart';
import '../datasources/request_remote_data_source.dart';
import '../models/init_model.dart';
import '../models/request_model.dart';

class RequestRepositoryImpl implements RequestRepository {
  final RequestRemoteDataSource requestRemoteDataSource;

  RequestRepositoryImpl({
    required this.requestRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> createRequest(
      InitEntity init, String token, String hostId) async {
    try {
      InitModel initModel = InitModel(
        id: init.id,
        guests: init.guests,
        plannerId: init.plannerId,
        guestsNumber: init.guestsNumber,
        startsAt: init.startsAt,
        endsAt: init.endsAt,
        description: init.description,
        type: init.type,
        postType: init.postType,
        title: init.title,
        startingDate: init.startingDate,
        endingDate: init.endingDate,
        adultsOnly: init.adultsOnly,
        food: init.food,
        alcohol: init.alcohol,
        dressCode: init.dressCode,
      );

      final response =
          await requestRemoteDataSource.createRequest(initModel, token, hostId);

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
      String requestId, String plannerId, String token) async {
    try {
      final result = await requestRemoteDataSource.cancelRequest(
          requestId, plannerId, token);

      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to cancel request'));
    }
  }

  @override
  Future<Either<Failure, List<RequestEntity>>> getAllRequests(
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
      RequestEntity request, String token) async {
    try {
      // Convert request entity to request model
      RequestModel requestModel = RequestModel(
        hostId: request.hostId,
        id: request.id,
        plannerId: request.plannerId,
        guestsNumber: request.guestsNumber,
        startsAt: request.startsAt,
        endsAt: request.endsAt,
        description: request.description,
        type: request.type,
        postType: request.postType,
        title: request.title,
        startingDate: request.startingDate,
        endingDate: request.endingDate,
        adultsOnly: request.adultsOnly,
        food: request.food,
        alcohol: request.alcohol,
        dressCode: request.dressCode,
        hostName: request.hostName,
      );

      final result =
          await requestRemoteDataSource.updateRequest(requestModel, token);

      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to update request'));
    }
  }
}
