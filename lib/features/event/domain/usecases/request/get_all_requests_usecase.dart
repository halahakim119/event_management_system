import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/event_entity.dart';
import '../../repositories/request_repository.dart';

class GetAllRequestsUseCase {
  final RequestRepository repository;
  GetAllRequestsUseCase(this.repository);

  Future<Either<Failure, List<EventEntity>>> call(String plannerId) async {
    return await repository.getAllRequests(plannerId);
  }
}
