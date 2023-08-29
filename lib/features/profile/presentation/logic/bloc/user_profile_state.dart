part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserProfileState {}

class UserLoading extends UserProfileState {}

class UserDeleted extends UserProfileState {
  final String message;

  const UserDeleted({required this.message});

  @override
  List<Object> get props => [message];
}

class UserEdited extends UserProfileState {
  final String message;

  const UserEdited({required this.message});

  @override
  List<Object> get props => [message];
}

class PhoneNumberVerified extends UserProfileState {
  final String code;
  final String verificationCode;

  const PhoneNumberVerified({
    required this.code,
    required this.verificationCode,
  });

  @override
  List<Object> get props => [code, verificationCode];
}

class PhoneNumberUpdated extends UserProfileState {
  final String message;

  const PhoneNumberUpdated({required this.message});

  @override
  List<Object> get props => [message];
}

class UserError extends UserProfileState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}
