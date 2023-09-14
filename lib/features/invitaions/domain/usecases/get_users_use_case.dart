import 'package:dartz/dartz.dart';

import '../../../../../core/error/failure.dart';
import '../entities/participant_entity.dart';
import '../repositories/invitations_repository.dart';

class GetAllInvitationsUseCase {
  final InvitationsRepository repository;
  GetAllInvitationsUseCase(this.repository);

  Future<Either<Failure, List<ParticipantEntity>>> getUsers(
      List<String> numbers) async {
    return await repository.getUsers(numbers);
  }
}
