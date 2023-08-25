import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/init_entity.dart';
import '../../repositories/init_repository.dart';

class GetAllInitsUseCase {
  final InitRepository repository;
  GetAllInitsUseCase(this.repository);

  Future<Either<Failure, List<InitEntity>>> call(String plannerId) async {
    return await repository.getAllInits(plannerId);
  }
}
