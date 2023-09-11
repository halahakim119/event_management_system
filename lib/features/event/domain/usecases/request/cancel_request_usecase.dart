import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../../repositories/request_repository.dart';

class CancelRequestUseCase {
  final RequestRepository repository;
  CancelRequestUseCase(this.repository);

  Future<Either<Failure, String>> call(
      String id, String plannerId, String token) async {
    return await repository.cancelRequest(id, plannerId, token);
  }
}
