part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class SignUpWithPhoneRequested extends AuthenticationEvent {
  final String name;
  final String province;
  final String phoneNumber;
  final String password;

  SignUpWithPhoneRequested({
    required this.name,
    required this.province,
    required this.phoneNumber,
    required this.password,
  });
}

class SignInWithPhoneRequested extends AuthenticationEvent {
  final String phoneNumber;
  final String password;

  SignInWithPhoneRequested({
    required this.phoneNumber,
    required this.password,
  });
}

class VerifyPhoneSignUpRequested extends AuthenticationEvent {
  final String code;
  final String verificationCode;

  VerifyPhoneSignUpRequested({
    required this.code,
    required this.verificationCode,
  });
}

class ResetPasswordRequested extends AuthenticationEvent {
  final String phoneNumber;

  ResetPasswordRequested({
    required this.phoneNumber,
  });
}

class VerifyPhoneResetPasswordRequested extends AuthenticationEvent {
  final String code;
  final String verificationCode;
  final String newPassword;

  VerifyPhoneResetPasswordRequested({
    required this.code,
    required this.verificationCode,
    required this.newPassword,
  });
}
