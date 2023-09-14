import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/event_entity.dart';
import '../../repositories/request_repository.dart';

class CreateRequestUseCase {
  final RequestRepository repository;
  CreateRequestUseCase(this.repository);

  Future<Either<Failure, String>> call(EventEntity event) async {
    return await repository.createRequest(event);
  }
}
