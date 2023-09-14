import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/event_entity.dart';
import '../../../domain/usecases/init/create_init_usecase.dart';
import '../../../domain/usecases/init/delete_init_usecase.dart';
import '../../../domain/usecases/init/get_all_inits_usecase.dart';
import '../../../domain/usecases/init/update_init_usecase.dart';

part 'init_cubit.freezed.dart';
part 'init_state.dart';

class InitCubit extends Cubit<InitState> {
  final GetAllInitsUseCase getAllInitsUseCase;
  final CreateInitUseCase createInitUseCase;
  final DeleteInitUseCase deleteInitUseCase;
  final UpdateInitUseCase updateInitUseCase;

  InitCubit({
    required this.getAllInitsUseCase,
    required this.createInitUseCase,
    required this.deleteInitUseCase,
    required this.updateInitUseCase,
  }) : super(const InitState.initial());
// Method to fetch all events
  Future<void> getAllInit() async {
    emit(const InitState.loading());

    final result = await getAllInitsUseCase.call();

    return result.fold(
      (failure) => emit(InitState.error(message: failure.message)),
      (events) => emit(InitState.loaded(events: events)),
    );
  }

  // Method to create a new event
  Future<void> createInit({required EventEntity event}) async {
    emit(const InitState.loading());

    final result = await createInitUseCase.call(event);

    return result.fold(
      (failure) => emit(InitState.error(message: failure.message)),
      (message) => emit(InitState.created(message: message)),
    );
  }

  // Method to delete an event
  Future<void> deleteInit({required String id}) async {
    emit(const InitState.loading());

    final result = await deleteInitUseCase.call(id);

    return result.fold(
      (failure) => emit(InitState.error(message: failure.message)),
      (message) => emit(InitState.deleted(message: message)),
    );
  }

  // Method to update an event
  Future<void> updateInit({required EventEntity event}) async {
    emit(const InitState.loading());

    final result = await updateInitUseCase.call(event);

    return result.fold(
      (failure) => emit(InitState.error(message: failure.message)),
      (message) => emit(InitState.updated(message: message)),
    );
  }
}
