import 'package:dartz/dartz.dart';
import 'package:event_management_system/features/event/data/datasources/init_remote_data_source.dart';
import 'package:event_management_system/features/event/data/models/init_model.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entities/init_entity.dart';
import '../../domain/repositories/init_repository.dart';

class InitRepositoryImpl implements InitRepository {
  final InitRemoteDataSource initRemoteDataSource;
  InitRepositoryImpl({
    required this.initRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> createInit(
      InitEntity init, String token) async {
    try {
      InitModel initModel = InitModel(
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
          dressCode: init.dressCode);
      final response = await initRemoteDataSource.createInit(initModel, token);
      return response.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } on ServerException {
      return Left(ServerFailure('failed to create'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteInit(
      String initId, String plannerId, String token) async {
    try {
      final result =
          await initRemoteDataSource.deleteInit(initId, plannerId, token);
      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to delete'));
    }
  }

  @override
  Future<Either<Failure, List<InitEntity>>> getAllInits(
      String plannerId) async {
    try {
      final result = await initRemoteDataSource.getAllInits(plannerId);
      return result.fold(
        (failure) => Left(failure),
        (data) => Right(data),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to get all data'));
    }
  }

  @override
  Future<Either<Failure, String>> updateInit(
      InitEntity init, String token) async {
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
          dressCode: init.dressCode);
      final result = await initRemoteDataSource.updateInit(initModel, token);
      return result.fold(
        (failure) => Left(failure),
        (message) => Right(message),
      );
    } catch (e) {
      return Left(ServerFailure('Failed to get all data'));
    }
  }
}
