// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'draft_bloc.dart';

abstract class DraftEvent extends Equatable {
  const DraftEvent();

  @override
  List<Object> get props => [];
}

class DraftAddRequested extends DraftEvent {
  const DraftAddRequested({
    required this.draft,
  });

  final Draft draft;
}

class DraftEditRequested extends DraftEvent {
  const DraftEditRequested({
    required this.draft,
  });

  final Draft draft;
}

class DraftDeleteRequested extends DraftEvent {
  const DraftDeleteRequested({
    required this.id,
  });

  final String id;
}
