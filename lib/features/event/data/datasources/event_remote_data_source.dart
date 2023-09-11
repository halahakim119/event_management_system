import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<Either<Failure, List<EventModel>>> getAllEvents(String plannerId);
  Future<Either<Failure, String>> updateEvent(EventModel event, String token);
  Future<Either<Failure, String>> cancelEvent(EventModel event, String token);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final String baseUrl;

  EventRemoteDataSourceImpl({required this.baseUrl});

  @override
  Future<Either<Failure, String>> cancelEvent(
      EventModel event, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/event/cancel'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
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
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Right('event canceled successfully');
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('error')) {
          final errorMessage = jsonResponse['error'];
          return Left(ServerFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to cancel event');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllEvents(
      String plannerId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/events/get'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "plannerId": plannerId,
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse.containsKey('data')) {
        final eventsJsonList = jsonResponse['data'] as List<dynamic>;
        final events =
            eventsJsonList.map((json) => EventModel.fromJsonEvent(json)).toList();
        return Right(events);
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('error')) {
          final errorMessage = jsonResponse['error'];
          return Left(ServerFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to retrieve events');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> updateEvent(
      EventModel event, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/event/edit'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
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
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return Right('event updated successfully');
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('error')) {
          final errorMessage = jsonResponse['error'];
          return Left(ServerFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to update event');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
