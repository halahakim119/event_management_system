import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../user/data/models/user_model.dart';
import '../models/event_model.dart';

abstract class RequestRemoteDataSource {
  Future<Either<Failure, List<EventModel>>> getAllRequests();
  Future<Either<Failure, String>> createRequest(EventModel event);
  Future<Either<Failure, String>> updateRequest(EventModel event);
  Future<Either<Failure, String>> cancelRequest(String id);
}

class RequestRemoteDataSourceImpl implements RequestRemoteDataSource {
  final String baseUrl;
  final UserModel? user;
  RequestRemoteDataSourceImpl({
    required this.baseUrl,
    required this.user,
  });

  @override
  Future<Either<Failure, String>> cancelRequest(String id) async {
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
          return const Right('request canceled successfully');
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('error')) {
            final errorMessage = jsonResponse['error'];
            return Left(ServerFailure(errorMessage));
          }
        } else if (response.statusCode == 500) {
          throw ServerFailure('Something went wrong');
        }
        throw ApiException('Failed to cancel request');
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllRequests() async {
    try {
      if (user != null) {
        final uri = Uri.parse('$baseUrl/api/request')
            .replace(queryParameters: {'plannerId': user!.id});

        final response = await http.get(
          uri,
          headers: {'Authorization': 'Bearer ${user!.token}'},
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200 && jsonResponse.containsKey('data')) {
          final requestsJsonList = jsonResponse['data'] as List<dynamic>;
          final events = requestsJsonList
              .map((json) => EventModel.fromJson(json))
              .toList();
          return Right(events);
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('error')) {
            final errorMessage = jsonResponse['error'];
            return Left(ServerFailure(errorMessage));
          }
        } else if (response.statusCode == 500) {
          throw ServerFailure('Something went wrong');
        }
        throw ApiException('Failed to retrieve requests');
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> createRequest(EventModel event) async {
    try {
      if (user != null) {
        final response = await http.post(
          Uri.parse('$baseUrl/api/request'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            "id": event.id,
            "guests": event.guestsNumbers,
            "plannerId": event.plannerId,
            "token": user!.token,
            "hostId": event.host!.id,
          }),
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return const Right('request created successfully');
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('error')) {
            final errorMessage = jsonResponse['error'];
            return Left(ServerFailure(errorMessage));
          }
        } else if (response.statusCode == 500) {
          throw ServerFailure('Something went wrong');
        }
        throw ApiException('Failed to create request');
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> updateRequest(EventModel event) async {
    try {
      if (user != null) {
        final response = await http.put(
          Uri.parse('$baseUrl/api/request'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({
            ...event.toJson(),
            "token": user!.token,
          }),
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          return const Right('request updated successfully');
        } else if (response.statusCode == 400) {
          if (jsonResponse.containsKey('error')) {
            final errorMessage = jsonResponse['error'];
            return Left(ServerFailure(errorMessage));
          }
        } else if (response.statusCode == 500) {
          throw ServerFailure('Something went wrong');
        }
        throw ApiException('Failed to update request');
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
