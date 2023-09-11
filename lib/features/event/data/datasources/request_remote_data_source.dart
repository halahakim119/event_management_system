import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../models/event_model.dart';

abstract class RequestRemoteDataSource {
  Future<Either<Failure, List<EventModel>>> getAllRequests(String plannerId);
  Future<Either<Failure, String>> createRequest(EventModel event, String token);
  Future<Either<Failure, String>> updateRequest(EventModel event, String token);
  Future<Either<Failure, String>> cancelRequest(
      String requestId, String plannerId, String token);
}

class RequestRemoteDataSourceImpl implements RequestRemoteDataSource {
  final String baseUrl;

  RequestRemoteDataSourceImpl(this.baseUrl);

  @override
  Future<Either<Failure, String>> cancelRequest(
      String id, String plannerId, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/request?id=$id&plannerId=$plannerId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
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
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllRequests(
      String plannerId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/requests/get'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "plannerId": plannerId,
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse.containsKey('data')) {
        final requestsJsonList = jsonResponse['data'] as List<dynamic>;
        final events = requestsJsonList
            .map((json) => EventModel.fromJsonRequest(json))
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
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> createRequest(
      EventModel event, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/request'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "id": event.id,
          "guests": event.guestsNumbers,
          "plannerId": event.plannerId,
          "token": token,
          "hostId": event.hostId,
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
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> updateRequest(
      EventModel event, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/request'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          ...event.toJsonRequest(),
          "token": token,
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
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
