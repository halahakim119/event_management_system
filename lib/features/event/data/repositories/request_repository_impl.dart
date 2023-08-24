import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

import '../../domain/entities/init_entity.dart';

import '../../domain/entities/request_entity.dart';

import '../../domain/repositories/request_repository.dart';

class RequestRepositoryImpl implements RequestRepository {
  @override
  Future<Either<Failure, String>> cancelRequest(
      String requestId, String plannerId, String token) {
    // TODO: implement cancelRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> createRequest(
      InitEntity init, String token, String hostId) {
    // TODO: implement createRequest
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<RequestEntity>>> getAllRequests(
      String plannerId) {
    // TODO: implement getAllRequests
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> updateRequest(
      RequestEntity request, String token) {
    // TODO: implement updateRequest
    throw UnimplementedError();
  }
}
