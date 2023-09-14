import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/participant_entity.dart';

abstract class InvitationsRepository {
  Future<Either<Failure, List<ParticipantEntity>>> getUsers(
      List<String> numbers);
}
