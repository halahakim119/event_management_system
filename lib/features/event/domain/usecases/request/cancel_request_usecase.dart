import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/event_repository.dart';

class CancelRequestUseCase {
  final EventRepository repository;
  CancelRequestUseCase(this.repository);

  Future<Either<Failure, String>> call(
      String requestId, String plannerId, String token) async {
    return await repository.cancelRequest(requestId, plannerId, token);
  }
}
