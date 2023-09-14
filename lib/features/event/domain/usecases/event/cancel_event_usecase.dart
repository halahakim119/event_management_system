import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/event_entity.dart';
import '../../repositories/event_repository.dart';

class CancelEventUseCase {
  final EventRepository repository;
  CancelEventUseCase(this.repository);

  Future<Either<Failure, String>> call(EventEntity event) async {
    return await repository.cancelEvent(event);
  }
}
