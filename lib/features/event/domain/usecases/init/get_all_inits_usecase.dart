import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/init_entity.dart';
import '../../repositories/event_repository.dart';

class GetAllInitsUseCase {
  final EventRepository repository;
  GetAllInitsUseCase(this.repository);

  Future<Either<Failure, List<InitEntity>>> call(String plannerId) async {
    return await repository.getAllInits(plannerId);
  }
}