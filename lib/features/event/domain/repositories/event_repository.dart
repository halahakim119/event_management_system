import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/event_entity.dart';

abstract class EventRepository {
  Future<Either<Failure, String>> create(EventEntity event);
  Future<Either<Failure, String>> delete(String id);
}
