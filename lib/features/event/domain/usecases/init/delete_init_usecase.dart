import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/init_repository.dart';
class DeleteInitUseCase {
  final InitRepository repository;
  DeleteInitUseCase(this.repository);

  Future<Either<Failure, String>> call(String initId, String plannerId, String token) async {
    return await repository.deleteInit(initId, plannerId, token);
  }
}