import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/request_entity.dart';
import '../../repositories/event_repository.dart';

class UpdateRequestUseCase {
  final EventRepository repository;
  UpdateRequestUseCase(this.repository);

  Future<Either<Failure, String>> call(
      RequestEntity request, String token) async {
    return await repository.updateRequest(request, token);
  }
}
