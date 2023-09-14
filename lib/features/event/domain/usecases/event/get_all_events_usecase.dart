import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../entities/event_entity.dart';
import '../../repositories/event_repository.dart';

class GetAllEventsUseCase {
  final EventRepository repository;
  GetAllEventsUseCase(this.repository);

  Future<Either<Failure, List<EventEntity>>> call() async {
    return await repository.getAllEvents();
  }
}
