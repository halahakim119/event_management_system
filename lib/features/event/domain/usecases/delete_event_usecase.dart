import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../repositories/event_repository.dart';

class DeleteEventUseCase {
  final EventRepository repository;
  DeleteEventUseCase(this.repository);

  Future<Either<Failure, String>> call(String id) async {
    return await repository.delete(id);
  }
}
