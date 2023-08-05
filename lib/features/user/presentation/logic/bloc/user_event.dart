part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {
  final String userId;

  GetUserEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteUserEvent extends UserEvent {
  final String userId;
  final String token;

  DeleteUserEvent(this.userId, this.token);

  @override
  List<Object> get props => [userId, token];
}

class EditUserEvent extends UserEvent {
  final String userId;
  final String token;
  final String name;

  final String password;
  final String province;

  const EditUserEvent(
      this.userId, this.token, this.name, this.password, this.province);

  @override
  List<Object> get props => [userId, token, name];
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

  UpdatePhoneNumberEvent(this.code, this.verificationCode);

  @override
  List<Object> get props => [code, verificationCode];
}
