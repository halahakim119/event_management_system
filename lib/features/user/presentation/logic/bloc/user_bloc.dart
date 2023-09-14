// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/delete_user_use_case.dart';
import '../../../domain/usecases/edit_user_use_case.dart';
import '../../../domain/usecases/get_user_use_case.dart';
import '../../../domain/usecases/update_phone_number_use_case.dart';
import '../../../domain/usecases/verify_phone_number_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final EditUserUseCase editUserUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final UpdatePhoneNumberUseCase updatePhoneNumberUseCase;
  UserBloc({
    required this.getUserUseCase,
    required this.deleteUserUseCase,
    required this.editUserUseCase,
    required this.verifyPhoneNumberUseCase,
    required this.updatePhoneNumberUseCase,
  }) : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await getUserUseCase.getUser(event.userId);
      return emit(result.fold(
        (failure) => UserError(message: failure.message),
        (user) => UserLoaded(user: user),
      ));
    });
    on<DeleteUserEvent>((event, emit) async {
      emit(UserLoading());
      final result =
          await deleteUserUseCase.deleteUser(event.userId, event.token);
      return emit(result.fold(
        (failure) => UserError(message: failure.message),
        (message) => UserDeleted(message: message),
      ));
    });

    on<EditUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await editUserUseCase.editUser(
          event.userId, event.token, event.name, event.province);
      return emit(result.fold(
        (failure) => UserError(message: failure.message),
        (message) => UserEdited(message: message),
      ));
    });

    on<VerifyPhoneNumberEvent>((event, emit) async {
      emit(UserLoading());
      final result = await verifyPhoneNumberUseCase.verifyPhoneNumber(
        event.userId,
        event.phoneNumber,
        event.token,
      );
      return emit(result.fold(
        (failure) => UserError(message: failure.message),
        (code) => PhoneNumberVerified(
            code: code['code']!, verificationCode: code['verificationCode']!),
      ));
    });

    on<UpdatePhoneNumberEvent>((event, emit) async {
      emit(UserLoading());
      final result = await updatePhoneNumberUseCase.updatePhoneNumber(
        event.code,
        event.verificationCode,
      );
      return emit(result.fold(
        (failure) => UserError(message: failure.message),
        (message) => PhoneNumberUpdated(message: message),
      ));
    });
  }
}
