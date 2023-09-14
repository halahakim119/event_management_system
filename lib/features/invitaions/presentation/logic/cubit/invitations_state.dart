part of 'invitations_cubit.dart';

@immutable
@freezed
sealed class InvitationsState with _$InvitationsState {
  const factory InvitationsState.initial() = _Initial;
  const factory InvitationsState.loading() = _Loading;
  const factory InvitationsState.loaded(
      {required List<ParticipantEntity> users}) = _Loaded;

  const factory InvitationsState.error({required String message}) = _Error;
}
