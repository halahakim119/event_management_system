import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../core/error/failure.dart';
import '../models/init_model.dart';

abstract class InitRemoteDataSource {
  Future<Either<Failure, List<InitModel>>> getAllInits(String plannerId);
  Future<Either<Failure, String>> createInit(InitModel init, String token);
  Future<Either<Failure, String>> updateInit(InitModel init, String token);
  Future<Either<Failure, String>> deleteInit(
      String initId, String plannerId, String token);
}

class InitRemoteDataSourceImpl implements InitRemoteDataSource {
  final IO.Socket socket;

  InitRemoteDataSourceImpl(this.socket);

  @override
  Future<Either<Failure, String>> deleteInit(
      String initId, String plannerId, String token) async {
    final completer = Completer<Either<Failure, String>>();

    socket.emit("init-delete", {
      "id": initId,
      "plannerId": plannerId,
      "token": token,
    });

    socket.on("init-delete-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        log(response['data'].toString());
        completer.complete(const Right('deleted successfully'));
      }
    });
    return completer.future;
  }

  @override
  Future<Either<Failure, List<InitModel>>> getAllInits(String plannerId) async {
    final completer = Completer<Either<Failure, List<InitModel>>>();

    socket.emit("inits-get", {
      "plannerId": plannerId,
    });

    socket.on("inits-get-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        final initsJsonList = response['data'] as List<dynamic>;
        final inits =
            initsJsonList.map((json) => InitModel.fromJson(json)).toList();
        completer.complete(Right(inits));
      }
    });

    return completer.future;
  }

  @override
  Future<Either<Failure, String>> createInit(
      InitModel init, String token) async {
    final completer = Completer<Either<Failure, String>>();

    socket.emit("init-create", {
      "adultsOnly": init.adultsOnly,
      "alcohol": init.alcohol,
      "description": init.description,
      "dressCode": init.dressCode,
      "endingDate": init.endingDate.toIso8601String(),
      "endsAt": init.endsAt.toIso8601String(),
      "food": init.food,
      "startingDate": init.startingDate.toIso8601String(),
      "startsAt": init.startsAt.toIso8601String(),
      "guestsNumber": init.guestsNumber,
      "postType": init.postType,
      "type": init.type,
      "title": init.title,
      "plannerId": init.plannerId,
      "token": token,
    });

    socket.on("init-create-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        log(response['data'].toString());
        completer.complete(const Right('created successfully'));
      }
    });

    return completer.future;
  }

  @override
  Future<Either<Failure, String>> updateInit(
      InitModel init, String token) async {
    final completer = Completer<Either<Failure, String>>();

    socket.emit("init-edit", {
      "id": init.id,
      "adultsOnly": init.adultsOnly,
      "alcohol": init.alcohol,
      "description": init.description,
      "dressCode": init.dressCode,
      "endingDate": init.endingDate.toIso8601String(),
      "endsAt": init.endsAt.toIso8601String(),
      "food": init.food,
      "startingDate": init.startingDate.toIso8601String(),
      "startsAt": init.startsAt.toIso8601String(),
      "guestsNumber": init.guestsNumber,
      "postType": init.postType,
      "type": init.type,
      "title": init.title,
      "plannerId": init.plannerId,
      "token": token,
    });

    socket.on("init-edit-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        log(response['data'].toString());
        completer.complete(const Right('updated successfully'));
      }
    });

    return completer.future;
  }
}
