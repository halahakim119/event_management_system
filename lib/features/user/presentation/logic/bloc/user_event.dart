part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}
class GetUserEvent extends UserEvent {
  final String userId;

  const GetUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}