// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/event_entity.dart';

import '../../../domain/usecases/event/cancel_event_usecase.dart';
import '../../../domain/usecases/event/get_all_events_usecase.dart';
import '../../../domain/usecases/event/update_event_usecase.dart';

part 'event_cubit.freezed.dart';
part 'event_state.dart';

class EventCubit extends Cubit<EventState> {
  final GetAllEventsUseCase getAllEventsUseCase;
  final CancelEventUseCase cancelEventUseCase;
  final UpdateEventUseCase updateEventUseCase;


  EventCubit({
    required this.getAllEventsUseCase,
    required this.cancelEventUseCase,
    required this.updateEventUseCase,

  }) : super(const EventState.initial());

  Future<void> getAllEvents() async {
    emit(const EventState.loading());

    final result = await getAllEventsUseCase.call();

    return result.fold(
      (failure) => emit(EventState.error(message: failure.message)),
      (events) => emit(EventState.loaded(events: events)),
    );
  }

  Future<void> cancelEvent({required EventEntity event}) async {
    emit(const EventState.loading());

    final result = await cancelEventUseCase.call(event);

    return result.fold(
      (failure) => emit(EventState.error(message: failure.message)),
      (message) => emit(EventState.deleted(message: message)),
    );
  }

  Future<void> updateEvent({required EventEntity event}) async {
    emit(const EventState.loading());

    final result = await updateEventUseCase.call(event);

    return result.fold(
      (failure) => emit(EventState.error(message: failure.message)),
      (message) => emit(EventState.updated(message: message)),
    );
  }

 
}
