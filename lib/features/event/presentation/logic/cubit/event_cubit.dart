import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/event_entity.dart';
import '../../../domain/usecases/create_event_usecase.dart';
import '../../../domain/usecases/delete_event_usecase.dart';

part 'event_cubit.freezed.dart';
part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  
  final CreateEventUseCase createEventUseCase;
  final DeleteEventUseCase deleteEventUseCase;


  EventCubit({
   
    required this.createEventUseCase,
    required this.deleteEventUseCase,
  
 
  }) : super(const EventState.initial());

  // Method to create a new event
  Future<void> create({required EventEntity event}) async {
    emit(const EventState.loading());

    final result = await createEventUseCase.call(event);

    return result.fold(
      (failure) => emit(EventState.error(message: failure.message)),
      (message) => emit(EventState.created(message: message)),
    );
  }

  // Method to delete an event
  Future<void> delete({required String id}) async {
    emit(const EventState.loading());

    final result = await deleteEventUseCase.call(id);

    return result.fold(
      (failure) => emit(EventState.error(message: failure.message)),
      (message) => emit(EventState.deleted(message: message)),
    );
  }

}
