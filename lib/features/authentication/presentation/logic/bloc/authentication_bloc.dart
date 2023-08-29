import 'package:bloc/bloc.dart';

import '../../../../user/domain/entities/user_entity.dart';
import '../../../domain/usecases/reset_password.dart';
import '../../../domain/usecases/signin_with_phone.dart';
import '../../../domain/usecases/signup_with_phone.dart';
import '../../../domain/usecases/verify_phone_reset_password.dart';
import '../../../domain/usecases/verify_phone_signup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final SignUpWithPhone signUpWithPhone;
  final SignInWithPhone signInWithPhone;
  final ResetPassword resetPassword;
  final VerifyPhoneSignUp verifyPhoneSignUp;
  final VerifyPhoneResetPassword verifyPhoneResetPassword;

  AuthenticationBloc({
    required this.signUpWithPhone,
    required this.signInWithPhone,
    required this.resetPassword,
    required this.verifyPhoneSignUp,
    required this.verifyPhoneResetPassword,
  }) : super(AuthenticationInitial()) {
    on<SignUpWithPhoneRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await signUpWithPhone.call(
        name: event.name,
        province: event.province,
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      return result.fold(
        (failure) => emit(AuthenticationSignupFailure(failure.message)),
        (code) => emit(
          VerifyPhoneNumber(
            code: code['code']!,
            verificationCode: code['verificationCode']!,
          ),
        ),
      );
    });

    on<VerifyPhoneSignUpRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await verifyPhoneSignUp.call(
        code: event.code,
        verificationCode: event.verificationCode,
      );
      return result.fold(
        (failure) => emit(VerifyPhoneNumberFailure(failure.message)),
        (_) => emit(VerifyPhoneNumberSuccess()),
      );
    });

    on<SignInWithPhoneRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await signInWithPhone.call(
        phoneNumber: event.phoneNumber,
        password: event.password,
      );
      return result.fold(
        (failure) => emit(AuthenticationSigninFailure(failure.message)),
        (userEntity) => emit(
          AuthenticationSigninSuccess(userEntity: userEntity),
        ),
      );
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await resetPassword.call(phoneNumber: event.phoneNumber);
      return result.fold(
        (failure) => emit(ResetPasswordFailure(failure.message)),
        (code) => emit(
          VerifyPhoneNumber(
            code: code['code']!,
            verificationCode: code['verificationCode']!,
          ),
        ),
      );
    });

    on<VerifyPhoneResetPasswordRequested>((event, emit) async {
      emit(AuthenticationLoading());
      final result = await verifyPhoneResetPassword.call(
        code: event.code,
        verificationCode: event.verificationCode,
        newPassword: event.newPassword,
      );
      return result.fold(
        (failure) => emit(ResetPasswordFailure(failure.message)),
        (_) => emit(ResetPasswordSuccess()),
      );
    });
  }
}
