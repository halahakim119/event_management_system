import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/init_entity.dart';
import '../entities/request_entity.dart';

abstract class RequestRepository {
  Future<Either<Failure, List<RequestEntity>>> getAllRequests(String plannerId);
  Future<Either<Failure, String>> createRequest(
      InitEntity init, String token, String hostId);
  Future<Either<Failure, String>> updateRequest(
      RequestEntity request, String token);
  Future<Either<Failure, String>> cancelRequest(
      String requestId, String plannerId, String token);
}
