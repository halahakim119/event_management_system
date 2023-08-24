import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/init_entity.dart';
import '../../repositories/init_repository.dart';
class UpdateInitUseCase {
  final InitRepository repository;
  UpdateInitUseCase(this.repository);

  Future<Either<Failure, String>> call(InitEntity init, String token) async {
    return await repository.updateInit(init, token);
  }
}