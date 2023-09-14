import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/init_repository.dart';

class DeleteInitUseCase {
  final InitRepository repository;
  DeleteInitUseCase(this.repository);

  Future<Either<Failure, String>> call(String id) async {
    return await repository.deleteInit(id);
  }
}
