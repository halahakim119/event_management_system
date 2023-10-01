part of 'draft_bloc.dart';

abstract class DraftState extends Equatable {
  const DraftState();

  @override
  List<Object> get props => [];
}

class DraftInitialState extends DraftState {
  const DraftInitialState();
}

class DraftInProgressState extends DraftState {
  const DraftInProgressState();

  @override
  List<Object> get props => [];
}

class DraftAddedState extends DraftState {
  const DraftAddedState();

  @override
  List<Object> get props => [];
}

class DraftEditedState extends DraftState {
  const DraftEditedState();

  @override
  List<Object> get props => [];
}

class DraftDeletedState extends DraftState {
  const DraftDeletedState();

  @override
  List<Object> get props => [];
}

class DraftFailureState extends DraftState {
  const DraftFailureState(this.error);

  final String error;

  @override
  List<Object> get props => [error];
}
