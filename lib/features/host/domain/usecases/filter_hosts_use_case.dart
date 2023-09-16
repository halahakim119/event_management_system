import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/filter_host_entity.dart';
import '../entities/host_entity.dart';
import '../repositories/host_repository.dart';

class FilterHostsUseCase {
  final HostRepository repository;

  FilterHostsUseCase(this.repository);

  Future<Either<Failure, List<HostEntity>>> filterHosts(
      {FilterHostEntity? filterHostEntity}) async {
    return repository.filterHosts(filterHostEntity: filterHostEntity);
  }
}
