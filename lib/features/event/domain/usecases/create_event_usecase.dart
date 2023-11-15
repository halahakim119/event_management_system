import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';
import '../repositories/event_repository.dart';

class CreateEventUseCase {
  final EventRepository repository;
  CreateEventUseCase(this.repository);

  Future<Either<Failure, String>> call(EventEntity event) async {
    return await repository.create(event);
  }
}
