part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

  @override
  List<Object> get props => [];
}

class DeleteUserEvent extends UserProfileEvent {
  final String userId;
  final String token;

  const DeleteUserEvent(this.userId, this.token);

  @override
  List<Object> get props => [userId, token];
}

class EditUserEvent extends UserProfileEvent {
  final String userId;
  final String token;
  final String name;

  final String province;

  const EditUserEvent(this.userId, this.token, this.name, this.province);

  @override
  List<Object> get props => [userId, token, name, province];
}

class VerifyPhoneNumberEvent extends UserProfileEvent {
  final String userId;
  final String phoneNumber;
  final String token;

  const VerifyPhoneNumberEvent(this.userId, this.phoneNumber, this.token);

  @override
  List<Object> get props => [userId, phoneNumber, token];
}

class UpdatePhoneNumberEvent extends UserProfileEvent {
  final String code;
  final String verificationCode;

  const UpdatePhoneNumberEvent(this.code, this.verificationCode);

  @override
  List<Object> get props => [code, verificationCode];
}
