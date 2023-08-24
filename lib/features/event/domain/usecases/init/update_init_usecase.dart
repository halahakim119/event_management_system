import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/init_entity.dart';
import '../../repositories/event_repository.dart';
class UpdateInitUseCase {
  final EventRepository repository;
  UpdateInitUseCase(this.repository);

  Future<Either<Failure, String>> call(InitEntity init, String token) async {
    return await repository.updateInit(init, token);
  }
}