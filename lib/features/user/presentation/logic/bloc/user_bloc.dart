import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/user_use_case.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCase getUserUseCase;
  UserBloc({required this.getUserUseCase}) : super(UserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(UserLoading());
      final result = await getUserUseCase.getUser(event.userId);
      return emit(result.fold(
        (failure) => UserError(message: failure.message),
        (user) => UserLoaded(user: user),
      ));
    });
  }
}
