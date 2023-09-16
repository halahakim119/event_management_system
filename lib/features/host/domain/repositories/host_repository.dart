import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/filter_host_entity.dart';
import '../entities/host_entity.dart';

abstract class HostRepository {
  Future<Either<Failure, List<HostEntity>>> filterHosts(
      {FilterHostEntity? filterHostEntity});
}
