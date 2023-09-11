part of 'event_cubit.dart';

@immutable
@freezed
sealed class EventState with _$EventState {
  const factory EventState.initial() = _Initial;
  const factory EventState.loading() = _Loading;
  const factory EventState.loaded({required List<EventEntity> events}) =
      _Loaded;
  const factory EventState.updated({required String message}) = _Updated;
  const factory EventState.deleted({required String message}) = _Deleted;
  const factory EventState.error({required String message}) = _Error;
}
