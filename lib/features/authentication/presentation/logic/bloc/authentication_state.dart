part of 'authentication_bloc.dart';

abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationSignupFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationSignupFailure(this.errorMessage);
}

class VerifyPhoneNumber extends AuthenticationState {
  final String code;
  final String verificationCode;

  VerifyPhoneNumber({
    required this.code,
    required this.verificationCode,
  });
}

class VerifyPhoneNumberSuccess extends AuthenticationState {}

class VerifyPhoneNumberFailure extends AuthenticationState {
  final String errorMessage;

  VerifyPhoneNumberFailure(this.errorMessage);
}

class AuthenticationSigninSuccess extends AuthenticationState {
  final UserEntity userEntity;

  AuthenticationSigninSuccess({required this.userEntity});
}

class AuthenticationSigninFailure extends AuthenticationState {
  final String errorMessage;

  AuthenticationSigninFailure(this.errorMessage);
}

class ResetPasswordSuccess extends AuthenticationState {}

class ResetPasswordFailure extends AuthenticationState {
  final String errorMessage;

  ResetPasswordFailure(this.errorMessage);
}

