import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/filter_host_entity.dart';
import '../../domain/entities/host_entity.dart';
import '../../domain/repositories/host_repository.dart';
import '../datasources/host_remote_data_source.dart';

class HostRepositoryImpl implements HostRepository {
  final HostRemoteDataSource hostRemoteDataSource;
  HostRepositoryImpl({
    required this.hostRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<HostEntity>>> filterHosts(
      {FilterHostEntity? filterHostEntity}) async {
    try {
      final result = await hostRemoteDataSource.filterHosts(
          filterHostEntity: filterHostEntity);
      return result.fold(
        (failure) => Left(failure),
        (hosts) => Right(hosts),
      );
    } catch (e) {
      return Left(ServerFailure('Failed'));
    }
  }
}
