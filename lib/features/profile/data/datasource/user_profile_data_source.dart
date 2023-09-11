import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../authentication/data/datasources/authentication_remote_data_source.dart';
import '../models/user_profile_model.dart';

abstract class UserProfileDataSource {
  Future<Either<Failure, String>> deleteUser(String id, String token);
  Future<Either<Failure, String>> editUser(
      String id, String token, String name, String province);

  Future<Either<Failure, Map<String, dynamic>>> verifyPhoneNumber(
      String id, String number, String token);
  Future<Either<Failure, String>> updatePhoneNumber(
      String code, String verificationCode);
}

class UserProfileDataSourceImpl implements UserProfileDataSource {
  final Box<UserProfileModel> _userBox;

  final AuthenticationRemoteDataSource authenticationRemoteDataSource;

  UserProfileDataSourceImpl(this._userBox, this.authenticationRemoteDataSource);

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
        await _userBox.clear();
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

        final user = _userBox.getAt(0);

        // Update the user data
        user!.name = userData['name'];
        user.province = userData['province'];

        // Save the updated user data back to the box
        _userBox.putAt(0, user);

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
        final user = _userBox.getAt(0);

        // Update the name in the user data
        user!.phoneNumber = jsonResponse['newNumber'];

        // Save the updated user data back to the box
        _userBox.putAt(0, user);
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
