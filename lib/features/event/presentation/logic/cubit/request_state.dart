part of 'request_cubit.dart';

@immutable
@freezed
sealed class RequestState with _$RequestState {
  const factory RequestState.initial() = _Initial;
  const factory RequestState.loading() = _Loading;
  const factory RequestState.loaded({required List<EventEntity> events}) =
      _Loaded;
  const factory RequestState.created({required String message}) = _Created;
  const factory RequestState.updated({required String message}) = _Updated;
  const factory RequestState.deleted({required String message}) = _Deleted;
  const factory RequestState.error({required String message}) = _Error;
}
