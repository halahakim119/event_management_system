import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/event_entity.dart';
import '../../repositories/init_repository.dart';

class CreateInitUseCase {
  final InitRepository repository;
  CreateInitUseCase(this.repository);

  Future<Either<Failure, String>> call(EventEntity event, String token) async {
    return await repository.createInit(event, token);
  }
}
