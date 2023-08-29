import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../core/error/failure.dart';
import '../models/init_model.dart';
import '../models/request_model.dart';

abstract class RequestRemoteDataSource {
  Future<Either<Failure, List<RequestModel>>> getAllRequests(String plannerId);
  Future<Either<Failure, String>> createRequest(
      InitModel init, String token, String hostId);
  Future<Either<Failure, String>> updateRequest(
      RequestModel request, String token);
  Future<Either<Failure, String>> cancelRequest(
      String requestId, String plannerId, String token);
}

class RequestRemoteDataSourceImpl implements RequestRemoteDataSource {
  final IO.Socket socket;

  RequestRemoteDataSourceImpl(this.socket);

  @override
  Future<Either<Failure, String>> cancelRequest(
      String requestId, String plannerId, String token) async {
    final completer = Completer<Either<Failure, String>>();

    socket.emit("request-cancel", {
      "id": requestId,
      "plannerId": plannerId,
      "token": token,
    });

    socket.on("request-cancel-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        log(response['data'].toString());
        completer.complete(const Right('request canceled successfully'));
      }
    });
    return completer.future;
  }

  @override
  Future<Either<Failure, List<RequestModel>>> getAllRequests(
      String plannerId) async {
    final completer = Completer<Either<Failure, List<RequestModel>>>();

    socket.emit("requests-get", {
      "plannerId": plannerId,
    });

    socket.on("requests-get-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        final requestsJsonList = response['data'] as List<dynamic>;
        final requests = requestsJsonList
            .map((json) => RequestModel.fromJson(json))
            .toList();
        completer.complete(Right(requests));
      }
    });

    return completer.future;
  }

  @override
  Future<Either<Failure, String>> createRequest(
      InitModel init, String token, String hostId) async {
    final completer = Completer<Either<Failure, String>>();

    socket.emit("request-create", {
      "init": init.toJson(),
      "token": token,
      "hostId": hostId,
    });

    socket.on("request-create-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        log(response['data'].toString());
        completer.complete(const Right('request created successfully'));
      }
    });

    return completer.future;
  }

  @override
  Future<Either<Failure, String>> updateRequest(
      RequestModel request, String token) async {
    final completer = Completer<Either<Failure, String>>();

    socket.emit("request-edit", {
      "id": request.id,
      "adultsOnly": request.adultsOnly,
      "alcohol": request.alcohol,
      "description": request.description,
      "dressCode": request.dressCode,
      "endingDate": request.endingDate.toIso8601String(),
      "endsAt": request.endsAt.toIso8601String(),
      "food": request.food,
      "startingDate": request.startingDate.toIso8601String(),
      "startsAt": request.startsAt.toIso8601String(),
      "guestsNumber": request.guestsNumber,
      "postType": request.postType,
      "type": request.type,
      "title": request.title,
      "token": token,
    });

    socket.on("request-edit-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        log(response['data'].toString());
        completer.complete(const Right('request updated successfully'));
      }
    });

    return completer.future;
  }
}
