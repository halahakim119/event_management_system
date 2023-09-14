import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/participant_entity.dart';
import '../../../domain/usecases/get_users_use_case.dart';

part 'invitations_cubit.freezed.dart';
part 'invitations_state.dart';

class InvitationsCubit extends Cubit<InvitationsState> {
  final GetAllInvitationsUseCase getAllInvitationsUseCase;
  InvitationsCubit(
    this.getAllInvitationsUseCase,
  ) : super(const InvitationsState.initial());

  Future<void> getUsers({required List<String> phoneNumbers}) async {
    emit(const InvitationsState.loading());

    final result = await getAllInvitationsUseCase.getUsers(phoneNumbers);

    return result.fold(
      (failure) => emit(InvitationsState.error(message: failure.message)),
      (users) => emit(InvitationsState.loaded(users: users)),
    );
  }
}
