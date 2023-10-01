part of 'draft_list_bloc.dart';

enum Status { initial, inProgress, success, failure }

class DraftListState extends Equatable {
  const DraftListState({
    this.status = Status.initial,
    this.draftList = const [],
    this.error = '',
  });

  final Status status;
  final List<Draft> draftList;
  final String error;

  @override
  List<Object> get props => [
        status,
        draftList,
        error,
      ];

  DraftListState copyWith({
    Status? status,
    List<Draft>? draftList,
    String? error,
  }) {
    return DraftListState(
      status: status ?? this.status,
      draftList: draftList ?? this.draftList,
      error: error ?? this.error,
    );
  }
}
