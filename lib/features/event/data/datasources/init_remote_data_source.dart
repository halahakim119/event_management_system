import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../user/data/models/user_model.dart';
import '../models/event_model.dart';

abstract class InitRemoteDataSource {
  Future<Either<Failure, List<EventModel>>> getAllInits();
  Future<Either<Failure, String>> createInit(EventModel event);
  Future<Either<Failure, String>> updateInit(EventModel event);
  Future<Either<Failure, String>> deleteInit(String id);
}

class InitRemoteDataSourceImpl implements InitRemoteDataSource {
  final String baseUrl;
  final UserModel? user;
  InitRemoteDataSourceImpl({
    required this.baseUrl,
    required this.user,
  });

  @override
  Future<Either<Failure, String>> deleteInit(String id) async {
    try {
      if (user != null) {
        final uri = Uri.parse('$baseUrl/api/init')
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
  Future<Either<Failure, List<EventModel>>> getAllInits() async {
    try {
      if (user != null) {
        final uri = Uri.parse('$baseUrl/api/init')
            .replace(queryParameters: {'plannerId': user!.id});

        final response = await http.get(
          uri,
          headers: {'Authorization': 'Bearer ${user!.token}'},
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200 && jsonResponse.containsKey('data')) {
          final initsJsonList = jsonResponse['data'] as List<dynamic>;
          final inits = initsJsonList
              .map((json) => EventModel.fromJsonInit(json))
              .toList();
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
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> createInit(EventModel event) async {
    try {
      if (user != null) {
        final data = jsonEncode({
          ...event.toJsonInit(),
          "token": user!.token,
        });
        log(data);

        final response = await http.post(Uri.parse('$baseUrl/api/init'),
            headers: {'Content-Type': 'application/json'}, body: data);

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
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> updateInit(EventModel event) async {
    try {
      if (user != null) {
        final response = await http.put(
          Uri.parse('$baseUrl/api/init'),
          body: jsonEncode({
            "id": event.id,
            ...event.toJsonInit(),
            "token": user!.token,
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
      }
      throw ApiException('User not logged in');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
