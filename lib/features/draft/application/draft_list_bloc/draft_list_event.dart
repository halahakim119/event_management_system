part of 'draft_list_bloc.dart';

abstract class DraftListEvent extends Equatable {
  const DraftListEvent();

  @override
  List<Object> get props => [];
}

class DraftListWatchRequested extends DraftListEvent {
  const DraftListWatchRequested();
}

class DraftListUpdated extends DraftListEvent {
  const DraftListUpdated(this.draftList);

  final List<Draft> draftList;

  @override
  List<Object> get props => [draftList];
}
