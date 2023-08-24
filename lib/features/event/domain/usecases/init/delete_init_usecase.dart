import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';

import '../../repositories/event_repository.dart';
class DeleteInitUseCase {
  final EventRepository repository;
  DeleteInitUseCase(this.repository);

  Future<Either<Failure, String>> call(String initId, String plannerId, String token) async {
    return await repository.deleteInit(initId, plannerId, token);
  }
}