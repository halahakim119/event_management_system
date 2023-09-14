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

class DeleteUserEvent extends UserEvent {
  final String userId;
  final String token;

  const DeleteUserEvent(this.userId, this.token);

  @override
  List<Object> get props => [userId, token];
}

class EditUserEvent extends UserEvent {
  final String userId;
  final String token;
  final String name;

  final String province;

  const EditUserEvent(this.userId, this.token, this.name, this.province);

  @override
  List<Object> get props => [userId, token, name, province];
}

class VerifyPhoneNumberEvent extends UserEvent {
  final String userId;
  final String phoneNumber;
  final String token;

  const VerifyPhoneNumberEvent(this.userId, this.phoneNumber, this.token);

  @override
  List<Object> get props => [userId, phoneNumber, token];
}

class UpdatePhoneNumberEvent extends UserEvent {
  final String code;
  final String verificationCode;

  const UpdatePhoneNumberEvent(this.code, this.verificationCode);

  @override
  List<Object> get props => [code, verificationCode];
}
