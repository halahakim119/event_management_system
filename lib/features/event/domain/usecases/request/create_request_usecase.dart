import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/init_entity.dart';
import '../../repositories/event_repository.dart';

class CreateRequestUseCase {
  final EventRepository repository;
  CreateRequestUseCase(this.repository);

  Future<Either<Failure, String>> call(
      InitEntity init, String token, String hostId) async {
    return await repository.createRequest(init, token, hostId);
  }
}
