import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/event_entity.dart';
import '../../repositories/request_repository.dart';

class UpdateRequestUseCase {
  final RequestRepository repository;
  UpdateRequestUseCase(this.repository);

  Future<Either<Failure, String>> call(EventEntity event, String token) async {
    return await repository.updateRequest(event, token);
  }
}
