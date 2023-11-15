import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../user/data/models/user_model.dart';
import '../models/event_model.dart';

abstract class EventRemoteDataSource {
  Future<Either<Failure, String>> create(EventModel event);

  Future<Either<Failure, String>> delete(String id);
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final String baseUrl;

  final UserModel? user = UserModel.getUserData();
  EventRemoteDataSourceImpl({
    required this.baseUrl,
  });

  @override
  Future<Either<Failure, String>> delete(String id) async {
    try {
      if (user != null) {
        final uri = Uri.parse('$baseUrl/api/request')
            .replace(queryParameters: {'id': id, 'plannerId': user!.id});

        final response = await http.delete(
          uri,
          headers: {'Authorization': 'Bearer ${user!.token}'},
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return const Right('deleted successfully');
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('error')) {
            final errorMessage = jsonResponse['error'];
            return Left(ServerFailure(errorMessage));
          }
        } else if (response.statusCode == 500) {
          throw ServerFailure('Something went wrong');
        }
        throw ApiException('Failed to delete init');
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> create(EventModel event) async {
    try {
      List<Map<String, dynamic>>? servicesWithQuantity =
          event.host?.services?.map((service) {
        return {
          "quantity": 5,
          "ServiceId": service.id,
        };
      }).toList();
      if (user != null) {
        final data = jsonEncode({
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
          "title": event.title,
          "plannerId": user!.id,
          "type": event.type,
          "hostId": event.host != null
              ? event.host!.id
              : event.hostRejected != null
                  ? event.hostRejected!.host!.id
                  : null,
          "guests": event.guestsNumbers ?? [],
          "services": servicesWithQuantity ?? [],
          "token": user!.token,
        });
        log(data.toString());

        final response = await http.post(Uri.parse('$baseUrl/api/request'),
            headers: {'Content-Type': 'application/json'}, body: data);

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return const Right('created successfully');
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('ERROR')) {
            final errorMessage = jsonResponse['ERROR'];
            return Left(ServerFailure(errorMessage));
          }
        } else if (response.statusCode == 500) {
          throw ServerFailure('Something went wrong');
        }
        throw ApiException('Failed to create event');
      }
      return Left(ServerFailure('user not logged in'));
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
