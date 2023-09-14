part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  final UserEntity user;

  const UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserDeleted extends UserState {
  final String message;

  const UserDeleted({required this.message});

  @override
  List<Object> get props => [message];
}

class UserEdited extends UserState {
  final String message;

  const UserEdited({required this.message});

  @override
  List<Object> get props => [message];
}

class PhoneNumberVerified extends UserState {
  final String code;
  final String verificationCode;

  const PhoneNumberVerified({
    required this.code,
    required this.verificationCode,
  });

  @override
  List<Object> get props => [code, verificationCode];
}

class PhoneNumberUpdated extends UserState {
  final String message;

  const PhoneNumberUpdated({required this.message});

  @override
  List<Object> get props => [message];
}

class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}
