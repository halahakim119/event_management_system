import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/filter_host_entity.dart';
import '../../../domain/entities/host_entity.dart';
import '../../../domain/usecases/filter_hosts_use_case.dart';

part 'hosts_cubit.freezed.dart';
part 'hosts_state.dart';

class HostsCubit extends Cubit<HostsState> {
  final FilterHostsUseCase filterHostsUseCase;
  HostsCubit(this.filterHostsUseCase) : super(const HostsState.initial());

  Future<void> filterHosts({FilterHostEntity? filterHostEntity}) async {
    emit(const HostsState.loading());

    final result = await filterHostsUseCase.filterHosts(
        filterHostEntity: filterHostEntity);

    return result.fold(
      (failure) => emit(HostsState.error(message: failure.message)),
      (hosts) => emit(HostsState.loaded(hosts: hosts)),
    );
  }
}
