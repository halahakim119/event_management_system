import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<Either<Failure, UserModel>> getUser(String id);
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
      if (response.statusCode == 200 && jsonResponse.containsKey('user')) {
        final userJson = jsonResponse['user'] as Map<String, dynamic>;
        final userData = UserModel.fromJson(userJson);

        // Assuming you store the retrieved user data in the box
        userBox.putAt(0, userData);

        return Right(userData);
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
}
