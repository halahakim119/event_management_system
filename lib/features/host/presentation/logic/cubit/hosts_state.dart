part of 'hosts_cubit.dart';

@immutable
@freezed
sealed class HostsState with _$HostsState {
  const factory HostsState.initial() = _Initial;
  const factory HostsState.loading() = _Loading;
  const factory HostsState.loaded({required List<HostEntity> hosts}) = _Loaded;
  const factory HostsState.error({required String message}) = _Error;
}
