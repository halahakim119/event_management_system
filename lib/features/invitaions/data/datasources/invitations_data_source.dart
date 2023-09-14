import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/strings/strings.dart';
import '../../domain/entities/participant_entity.dart';
import '../models/participant_model.dart';

abstract class InvitationsRemoteDataSource {
  Future<Either<Failure, List<ParticipantEntity>>> getUsers(
      List<String> numbers);
}

class InvitationsRemoteDataSourceImpl implements InvitationsRemoteDataSource {
  @override
  Future<Either<Failure, List<ParticipantEntity>>> getUsers(
      List<String> numbers) async {
    try {
      // Encode the numbers and join them with commas
      final encodedNumbers = numbers.map(Uri.encodeComponent).join(',');

      final uri = Uri.parse('$baseUrl/api/filter/user?numbers=$encodedNumbers');

      final response = await http.get(uri);
      if (response.body.isEmpty) {
        // Return a Left with an error message
        return Left(ServerFailure('No users available'));
      }

      // Parse the JSON response
      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse is Map<String, dynamic> &&
          jsonResponse.containsKey('users')) {
        final userList = jsonResponse['users'];

        if (userList is List) {
          // Use the same variable 'userList' to store the list
          final List<ParticipantModel> parsedUserList = userList
              .map((userJson) => ParticipantModel.fromJson(userJson))
              .toList();

          final List<ParticipantEntity> userEntityList =
              parsedUserList.map((participantModel) {
            return ParticipantEntity(
              id: participantModel.id,
              name: participantModel.name,
              phoneNumber: participantModel.phoneNumber,
            );
          }).toList();
          if (userEntityList.isEmpty) {
            return Left(ServerFailure('No users available'));
          }

          // Return the list of User objects as a Right value
          return Right(userEntityList);
        } else {
          // Handle the case where 'users' is not a list (empty response).
          return Left(ServerFailure('No users available'));
        }
      } else if (response.statusCode == 400) {
        // Handle the error response with a message
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('error')) {
          final errorMessage = jsonResponse['error'];
          return Left(ServerFailure(errorMessage));
        }
      } else if (response.statusCode == 500) {
        throw ServerFailure('Something went wrong');
      }
      throw ApiException('Failed');
    } on ApiException catch (e) {
      return Left(ApiExceptionFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
