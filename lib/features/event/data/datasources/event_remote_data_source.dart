import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../core/error/failure.dart';
import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<Either<Failure, List<EventModel>>> getAllEvents(String plannerId);
  Future<Either<Failure, String>> updateEvent(EventModel event, String token);
  Future<Either<Failure, String>> cancelEvent(EventModel event, String token);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final IO.Socket socket;

  EventRemoteDataSourceImpl(this.socket);

  @override
  Future<Either<Failure, String>> cancelEvent(
      EventModel event, String token) async {
    final completer = Completer<Either<Failure, String>>();

    socket.emit("event-cancel", {
      "plannerId": event.plannerId,
      "eventId": event.id,
      "hostId": event.hostId,
      "token": token,
      "adultsOnly": event.adultsOnly,
      "alcohol": event.alcohol,
      "description": event.description,
      "dressCode": event.dressCode,
      "endingDate": event.endingDate.toIso8601String(),
      "endsAt": event.endsAt.toIso8601String(),
      "food": event.food,
      "startingDate": event.startingDate.toIso8601String(),
      "startsAt": event.startsAt.toIso8601String(),
      "guestsNumber": event.guestsNumber,
      "postType": event.postType,
      "type": event.type,
      "title": event.title,
    });

    socket.on("event-cancel-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        log(response['data'].toString());
        completer.complete(const Right('event canceled successfully'));
      }
    });
    return completer.future;
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllEvents(
      String plannerId) async {
    final completer = Completer<Either<Failure, List<EventModel>>>();

    socket.emit("events-get", {
      "plannerId": plannerId,
    });

    socket.on("events-get-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        final eventsJsonList = response['data'] as List<dynamic>;
        final events =
            eventsJsonList.map((json) => EventModel.fromJson(json)).toList();
        completer.complete(Right(events));
      }
    });

    return completer.future;
  }

  @override
  Future<Either<Failure, String>> updateEvent(
      EventModel event, String token) async {
    final completer = Completer<Either<Failure, String>>();

    socket.emit("event-edit", {
      "plannerId": event.plannerId,
      "adultsOnly": event.adultsOnly,
      "alcohol": event.alcohol,
      "description": event.description,
      "dressCode": event.dressCode,
      "endingDate": event.endingDate.toIso8601String(),
      "endsAt": event.endsAt.toIso8601String(),
      "food": event.food,
      "startingDate": event.startingDate.toIso8601String(),
      "startsAt": event.startsAt.toIso8601String(),
      "guestsNumber": event.guestsNumber,
      "postType": event.postType,
      "type": event.type,
      "title": event.title,
      "token": token,
      "hostId": event.hostId,
      "eventId": event.id,
    });

    socket.on("event-edit-response", (response) {
      if (response['error']) {
        completer.complete(Left(ServerFailure(response['message'])));
      } else {
        log(response['data'].toString());
        completer.complete(const Right('event updated successfully'));
      }
    });

    return completer.future;
  }
}
