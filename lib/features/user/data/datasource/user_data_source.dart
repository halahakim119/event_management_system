import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../../../event/data/models/event_model.dart';
import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<Either<Failure, UserModel>> getUser(String id);
  Future<Either<Failure, String>> deleteUser(String id, String token);
  Future<Either<Failure, String>> editUser(
      String id, String token, String name, String province);

  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token);
  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode);
}

class UserDataSourceImpl implements UserDataSource {
  final Box<UserModel> userBox;

  UserDataSourceImpl({required this.userBox});

  @override
  Future<Either<Failure, UserModel>> getUser(String id) async {
    try {
      final response = await http.get(
        Uri.parse('http://35.180.62.182/api/user?id=$id'),
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 && jsonResponse.containsKey('data')) {
        final userDataJson = jsonResponse['data'] as Map<String, dynamic>;
        // Retrieve existing user data from Hive
        final existingUser = UserModel.getUserData();
        // Update the desired fields
        existingUser?.name = userDataJson['name'];
        existingUser?.phoneNumber = userDataJson['phoneNumber'];
        existingUser?.province = userDataJson['province'];
        if (userDataJson['following'] is List) {
          // Ensure 'following' is a List
          existingUser?.following =
              userDataJson['following'].cast<UserEntity>();
        }
        if (userDataJson['invites'] is List) {
          // Ensure 'invites' is a List
          existingUser?.invites = userDataJson['invites'].cast<EventEntity>();
        }
        final events = [
          ...(userDataJson['init'] as List<dynamic>)
              .map((eventJson) => EventModel.fromJson(eventJson).toEntity())
              .toList(),
          ...(userDataJson['eventsPlanned'] as List<dynamic>)
              .map((eventJson) => EventModel.fromJson(eventJson).toEntity())
              .toList(),
          ...(userDataJson['requests'] as List<dynamic>)
              .map((eventJson) => EventModel.fromJson(eventJson).toEntity())
              .toList(),
        ];

        existingUser?.events = events;

        log("userJson.toString()");
        log(existingUser!.events.toString());

        // Assuming you store the retrieved user data in the box
        userBox.putAt(0, existingUser);

        return Right(existingUser);
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to retrieve user data');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUser(String id, String token) async {
    try {
      final Uri uri = Uri.parse('http://35.180.62.182/api/user?id=$id');

      final response = await http.delete(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse.containsKey('message')) {
        await userBox.clear();
        return Right(jsonResponse['message']);
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to delete user');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> editUser(
      String id, String token, String name, String province) async {
    try {
      final response = await http.put(
        Uri.parse('http://35.180.62.182/api/user'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'id': id,
          'token': token,
          'name': name,
          'province': province,
        }),
      );

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final userData = jsonResponse['data'] as Map<String, dynamic>;

        final user = userBox.getAt(0);

        // Update the user data
        user!.name = userData['name'];
        user.province = userData['province'];

        // Save the updated user data back to the box
        userBox.putAt(0, user);

        return const Right('updated succesffuly');
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to update user name');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode) async {
    try {
      final response = await http.put(
        Uri.parse('http://35.180.62.182/api/user/changeNumber'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'code': code,
          'verificationCode': verificationCode,
        }),
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Access the user data from the box
        final user = userBox.getAt(0);

        // Update the name in the user data
        user!.phoneNumber = jsonResponse['newNumber'];

        // Save the updated user data back to the box
        userBox.putAt(0, user);
        return const Right('phpne number updated');
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to update phone number');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token) async {
    try {
      final Uri uri = Uri.parse('http://35.180.62.182/api/user/changeNumber');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'number': number,
          'id': id,
          'token': token,
        }),
      );

      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200 &&
          jsonResponse.containsKey('code') &&
          jsonResponse.containsKey('verificationCode')) {
        log(jsonResponse['code']);
        log(jsonResponse['verificationCode']);

        return Right({
          'code': jsonResponse['code'],
          'verificationCode': jsonResponse['verificationCode'],
        });
      } else if (response.statusCode == 400) {
        if (jsonResponse.containsKey('ERROR')) {
          final errorMessage = jsonResponse['ERROR'];
          return Left(ApiExceptionFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed to verify phone number');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
