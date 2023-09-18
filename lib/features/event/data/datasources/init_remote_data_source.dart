// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  final Box<UserModel> userBox;
  final UserModel? user = UserModel.getUserData();
  InitRemoteDataSourceImpl({
    required this.baseUrl,
    required this.userBox,
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
          // Delete the event from the user's events list in Hive
          user!.events?.removeWhere((event) => event.id == id);

          // Save the updated user data in Hive
          await userBox.put('userBox', user!);

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
          final inits =
              initsJsonList.map((json) => EventModel.fromJson(json)).toList();
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
          ...event.toJson(),
          "token": user!.token,
        });

        final response = await http.post(Uri.parse('$baseUrl/api/init'),
            headers: {'Content-Type': 'application/json'}, body: data);

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Parse the response event data
          final eventJson = jsonResponse['init'] as Map<String, dynamic>;
          final eventModel = EventModel.fromJson(eventJson);
          final event = eventModel.toEntity();
          // Add the event to the events list as the first element
          user!.events?.insert(0, event);

          // Save the updated user data in Hive
          await userBox.put('userBox', user!);

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
      return Left(ServerFailure('user not logged in'));
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
            ...event.toJson(),
            "token": user!.token,
          }),
        );

        final jsonResponse = jsonDecode(response.body);

        if (response.statusCode == 200) {
          // Update the event in the user's events list
          final updatedEvent = EventModel.fromJson(jsonResponse['init']);
          final userIndex =
              user!.events!.indexWhere((e) => e.id == updatedEvent.id);
          if (userIndex != -1) {
            user!.events![userIndex] = updatedEvent;
          } else {
            // If the event doesn't exist in the list, you can add it
            user!.events?.insert(userIndex, updatedEvent);
          }

          // Save the updated user data in Hive
          await userBox.put('userBox', user!);

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
