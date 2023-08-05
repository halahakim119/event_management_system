import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/user_crud_use_cases.dart';

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
      final result = await editUserUseCase.editUser(event.userId, event.token,
          event.name, event.password, event.province);
      return emit(result.fold(
        (failure) => UserError(message: failure.message),
        (_) => UserEdited(),
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
        (_) => PhoneNumberUpdated(),
      ));
    });
  }
}
