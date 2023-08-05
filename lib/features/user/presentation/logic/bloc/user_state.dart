part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserEntity user;

  UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class UserDeleted extends UserState {
  final String message;

  UserDeleted({required this.message});

  @override
  List<Object> get props => [message];
}

class UserEdited extends UserState {}

class PhoneNumberVerified extends UserState {
  final String code;
  final String verificationCode;

  PhoneNumberVerified({
    required this.code,
    required this.verificationCode,
  });

  @override
  List<Object> get props => [code, verificationCode];
}

class PhoneNumberUpdated extends UserState {}

class UserError extends UserState {
  final String message;

  UserError({required this.message});

  @override
  List<Object> get props => [message];
}
