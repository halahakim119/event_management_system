import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/event_entity.dart';
import '../../repositories/event_repository.dart';

class UpdateEventUseCase {
  final EventRepository repository;
  UpdateEventUseCase(this.repository);

  Future<Either<Failure, String>> call(EventEntity event, String token) async {
    return await repository.updateEvent(event, token);
  }
}
