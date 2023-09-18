import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../user/data/models/user_model.dart';
import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<Either<Failure, List<EventModel>>> getAllEvents();
  Future<Either<Failure, String>> updateEvent(EventModel event);
  Future<Either<Failure, String>> cancelEvent(EventModel event);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final String baseUrl;
  final UserModel? user = UserModel.getUserData();
  EventRemoteDataSourceImpl({
    required this.baseUrl,

  });

  @override
  Future<Either<Failure, String>> cancelEvent(EventModel event) async {
    try {
      if (user != null) {
        final response = await http.delete(
          Uri.parse('$baseUrl/api/event'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "plannerId": event.plannerId,
            "eventId": event.id,
            "hostId": event.host!.id,
            "token": user!.token,
            "adultsOnly": event.adultsOnly,
            "alcohol": event.alcohol,
            "description": event.description,
            "dressCode": event.dressCode,
            "endingDate": event.endingDate,
            "endsAt": event.endsAt,
            "food": event.food,
            "startingDate": event.startingDate,
            "startsAt": event.startsAt,
            "guestsNumber": event.guestsNumber,
            "postType": event.postType,
            "type": event.type,
            "title": event.title,
          }),
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return const Right('event canceled successfully');
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('error')) {
            final errorMessage = jsonResponse['error'];
            return Left(ServerFailure(errorMessage));
          }
        } else if (response.statusCode == 500) {
          throw ServerFailure('Something went wrong');
        }
        throw ApiException('Failed to cancel event');
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllEvents() async {
    try {
      if (user != null) {
        final uri = Uri.parse('$baseUrl/api/events')
            .replace(queryParameters: {'plannerId': user!.id});

        final response = await http.get(
          uri,
          headers: {'Authorization': 'Bearer ${user!.token}'},
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200 && jsonResponse.containsKey('data')) {
          final eventsJsonList = jsonResponse['data'] as List<dynamic>;
          final events =
              eventsJsonList.map((json) => EventModel.fromJson(json)).toList();
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
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> updateEvent(EventModel event) async {
    try {
      if (user != null) {
        final response = await http.post(
          Uri.parse('$baseUrl/api/event/edit'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "plannerId": event.plannerId,
            "adultsOnly": event.adultsOnly,
            "alcohol": event.alcohol,
            "description": event.description,
            "dressCode": event.dressCode,
            "endingDate": event.endingDate,
            "endsAt": event.endsAt,
            "food": event.food,
            "startingDate": event.startingDate,
            "startsAt": event.startsAt,
            "guestsNumber": event.guestsNumber,
            "postType": event.postType,
            "type": event.type,
            "title": event.title,
            "token": user!.token,
            "hostId": event.host!.id,
            "eventId": event.id,
          }),
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return const Right('event updated successfully');
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('error')) {
            final errorMessage = jsonResponse['error'];
            return Left(ServerFailure(errorMessage));
          }
        } else if (response.statusCode == 500) {
          throw ServerFailure('Something went wrong');
        }
        throw ApiException('Failed to update event');
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
