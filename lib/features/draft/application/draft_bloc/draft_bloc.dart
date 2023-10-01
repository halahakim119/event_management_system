import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/draft_repository.dart';
import '../../domain/entities/draft/draft.dart';

part 'draft_event.dart';
part 'draft_state.dart';

@injectable
class DraftBloc extends Bloc<DraftEvent, DraftState> {
  DraftBloc(
    this._draftRepository,
  ) : super(const DraftInitialState()) {
    on<DraftAddRequested>(_onDraftAddRequested);
    on<DraftEditRequested>(_onDraftEditRequested);
    on<DraftDeleteRequested>(_onDraftDeleteRequested);
  }

  final DraftRepository _draftRepository;

  FutureOr<void> _onDraftAddRequested(
    DraftAddRequested event,
    Emitter<DraftState> emit,
  ) async {
    emit(const DraftInProgressState());
    final draft = Draft(
        id: DateTime.now().toString(),
        title: event.draft.title,
        description: event.draft.description,
        adultsOnly: event.draft.adultsOnly,
        alcohol: event.draft.alcohol,
        endingDate: event.draft.endingDate,
        dressCode: event.draft.dressCode,
        endsAt: event.draft.endsAt,
        food: event.draft.food,
        guestsNumber: event.draft.guestsNumber,
        guestsNumbers: event.draft.guestsNumbers,
        postType: event.draft.postType,
        startingDate: event.draft.startingDate,
        startsAt: event.draft.startsAt,
        type: event.draft.type);
    try {
      await _draftRepository.add(draft);
      emit(const DraftAddedState());
    } on Exception {
      emit(const DraftFailureState('Something went wrong'));
    }
  }

  FutureOr<void> _onDraftEditRequested(
    DraftEditRequested event,
    Emitter<DraftState> emit,
  ) async {
    emit(const DraftInProgressState());
    final draft = Draft(
        id: event.draft.id,
        title: event.draft.title,
        description: event.draft.description,
        adultsOnly: event.draft.adultsOnly,
        alcohol: event.draft.alcohol,
        endingDate: event.draft.endingDate,
        dressCode: event.draft.dressCode,
        endsAt: event.draft.endsAt,
        food: event.draft.food,
        guestsNumber: event.draft.guestsNumber,
        guestsNumbers: event.draft.guestsNumbers,
        postType: event.draft.postType,
        startingDate: event.draft.startingDate,
        startsAt: event.draft.startsAt,
        type: event.draft.type);
    try {
      await _draftRepository.update(draft);
      emit(const DraftEditedState());
    } on Exception {
      emit(const DraftFailureState('Something went wrong'));
    }
  }

  FutureOr<void> _onDraftDeleteRequested(
    DraftDeleteRequested event,
    Emitter<DraftState> emit,
  ) async {
    emit(const DraftInProgressState());

    try {
      await _draftRepository.delete(event.id);
      emit(const DraftDeletedState());
    } on Exception {
      emit(const DraftFailureState('Something went wrong'));
    }
  }
}
