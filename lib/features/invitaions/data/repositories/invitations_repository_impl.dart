import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/participant_entity.dart';
import '../../domain/repositories/invitations_repository.dart';
import '../datasources/invitations_data_source.dart';

class InvitationsRepositoryImpl implements InvitationsRepository {
  final InvitationsRemoteDataSource invitationsRemoteDataSource;
  InvitationsRepositoryImpl({
    required this.invitationsRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<ParticipantEntity>>> getUsers(List<String> numbers) async {
    try {
      final result = await invitationsRemoteDataSource.getUsers(numbers);
      return result.fold(
        (failure) => Left(failure),
        (users) => Right(users),
      );
    } catch (e) {
      return Left(ServerFailure('Failed'));
    }
  }
}
