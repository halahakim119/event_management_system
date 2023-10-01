import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../data/repositories/draft_repository.dart';
import '../../domain/entities/draft/draft.dart';


part 'draft_list_event.dart';
part 'draft_list_state.dart';

@injectable
class DraftListBloc extends Bloc<DraftListEvent, DraftListState> {
  DraftListBloc(this._draftRepository) : super(const DraftListState()) {
    on<DraftListWatchRequested>(_onDraftListWatchRequested);
    on<DraftListUpdated>(_onDraftListUpdated);
  }

  final DraftRepository _draftRepository;
  StreamSubscription<List<Draft>>? _draftListSubscription;

  void _listenDraftList() {
    if (_draftListSubscription != null) {
      return;
    }
    _draftListSubscription = _draftRepository.watchAllDraft().listen((draftList) {
      if (state.draftList.length != draftList.length) {
        add(DraftListUpdated(draftList));
      }
    });
  }

  FutureOr<void> _onDraftListWatchRequested(
    DraftListWatchRequested event,
    Emitter<DraftListState> emit,
  ) async {
    final draftList = _draftRepository.loadAllDraft();
    emit(
      state.copyWith(
        status: Status.success,
        draftList: draftList,
      ),
    );
    _listenDraftList();
  }

  FutureOr<void> _onDraftListUpdated(
    DraftListUpdated event,
    Emitter<DraftListState> emit,
  ) {
    emit(
      state.copyWith(
        status: Status.success,
        draftList: event.draftList,
      ),
    );
  }

  @override
  Future<void> close() {
    _draftListSubscription?.cancel();
    return super.close();
  }
}
