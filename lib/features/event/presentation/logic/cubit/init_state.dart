part of 'init_cubit.dart';

@immutable
@freezed
sealed class InitState with _$InitState {
  const factory InitState.initial() = _Initial;
  const factory InitState.loading() = _Loading;
  const factory InitState.loaded({required List<EventEntity> events}) = _Loaded;
  const factory InitState.created({required String message}) = _Created;
  const factory InitState.updated({required String message}) = _Updated;
  const factory InitState.deleted({required String message}) = _Deleted;
  const factory InitState.error({required String message}) = _Error;
}

