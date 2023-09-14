import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/event_entity.dart';
import '../../../domain/usecases/request/cancel_request_usecase.dart';
import '../../../domain/usecases/request/create_request_usecase.dart';
import '../../../domain/usecases/request/get_all_requests_usecase.dart';
import '../../../domain/usecases/request/update_request_usecase.dart';

part 'request_cubit.freezed.dart';
part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  final GetAllRequestsUseCase getAllRequestsUseCase;
  final CreateRequestUseCase createRequestUseCase;
  final UpdateRequestUseCase updateRequestUseCase;
  final CancelRequestUseCase cancelRequestUseCase;

  RequestCubit({
    required this.getAllRequestsUseCase,
    required this.createRequestUseCase,
    required this.updateRequestUseCase,
    required this.cancelRequestUseCase,
  }) : super(const RequestState.initial());

  Future<void> getAllRequests() async {
    emit(const RequestState.loading());

    final result = await getAllRequestsUseCase.call();

    return result.fold(
      (failure) => emit(RequestState.error(message: failure.message)),
      (events) => emit(RequestState.loaded(events: events)),
    );
  }

  Future<void> createRequest({required EventEntity event}) async {
    emit(const RequestState.loading());

    final result = await createRequestUseCase.call(event);

    return result.fold(
      (failure) => emit(RequestState.error(message: failure.message)),
      (message) => emit(RequestState.created(message: message)),
    );
  }

  Future<void> updateRequest({required EventEntity event}) async {
    emit(const RequestState.loading());

    final result = await updateRequestUseCase.call(event);

    return result.fold(
      (failure) => emit(RequestState.error(message: failure.message)),
      (message) => emit(RequestState.updated(message: message)),
    );
  }

  Future<void> cancelRequest({required String id}) async {
    emit(const RequestState.loading());

    final result = await cancelRequestUseCase.call(id);

    return result.fold(
      (failure) => emit(RequestState.error(message: failure.message)),
      (message) => emit(RequestState.deleted(message: message)),
    );
  }
}
