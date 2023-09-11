import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../models/event_model.dart';

abstract class InitRemoteDataSource {
  Future<Either<Failure, List<EventModel>>> getAllInits(String plannerId);
  Future<Either<Failure, String>> createInit(EventModel event, String token);
  Future<Either<Failure, String>> updateInit(EventModel event, String token);
  Future<Either<Failure, String>> deleteInit(
      String id, String plannerId, String token);
}

class InitRemoteDataSourceImpl implements InitRemoteDataSource {
  final String baseUrl;

  InitRemoteDataSourceImpl({required this.baseUrl});

  @override
  Future<Either<Failure, String>> deleteInit(
      String id, String plannerId, String token) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/api/init?id=$id&plannerId=$plannerId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
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
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllInits(
      String plannerId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/inits/get'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "plannerId": plannerId,
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse.containsKey('data')) {
        final initsJsonList = jsonResponse['data'] as List<dynamic>;
        final inits =
            initsJsonList.map((json) => EventModel.fromJsonInit(json)).toList();
        return Right(inits);
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('error')) {
          final errorMessage = jsonResponse['error'];
          return Left(ServerFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to retrieve inits');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> createInit(
      EventModel event, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/init'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          ...event.toJsonInit(),
          "token": token,
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return const Right('created successfully');
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('error')) {
          final errorMessage = jsonResponse['error'];
          return Left(ServerFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to create init');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> updateInit(
      EventModel event, String token) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/init'),
        body: jsonEncode({
          "id": event.id,
          ...event.toJsonInit(),
          "token": token,
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return const Right('init updated successfully');
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('error')) {
          final errorMessage = jsonResponse['error'];
          return Left(ServerFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to update init');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
