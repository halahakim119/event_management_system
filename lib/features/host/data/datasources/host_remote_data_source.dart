import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/strings/strings.dart';
import '../../domain/entities/filter_host_entity.dart';
import '../../domain/entities/host_entity.dart';
import '../models/host_model.dart';

abstract class HostRemoteDataSource {
  Future<Either<Failure, List<HostEntity>>> filterHosts(
      {FilterHostEntity? filterHostEntity});
}

class HostRemoteDataSourceImpl implements HostRemoteDataSource {
  @override
  Future<Either<Failure, List<HostEntity>>> filterHosts(
      {FilterHostEntity? filterHostEntity}) async {
    try {
      // Construct the query parameters based on the provided FilterHostEntity
      Uri uri;
      if (filterHostEntity != null) {
        final Map<String, String> queryParameters = {};
        if (filterHostEntity.province != null) {
          queryParameters['province'] = filterHostEntity.province!;
        }
        if (filterHostEntity.minCapacity != null) {
          queryParameters['minCapacity'] =
              filterHostEntity.minCapacity!.toString();
        }
        if (filterHostEntity.maxCapacity != null) {
          queryParameters['maxCapacity'] =
              filterHostEntity.maxCapacity!.toString();
        }
        if (filterHostEntity.services != null &&
            filterHostEntity.services!.isNotEmpty) {
          queryParameters['services'] = filterHostEntity.services!.join(',');
        }
        if (filterHostEntity.category != null) {
          queryParameters['category'] = filterHostEntity.category!;
        }
        uri = Uri.parse('$baseUrl/api/filter/host')
            .replace(queryParameters: queryParameters);
      } else {
        uri = Uri.parse('$baseUrl/api/filter/host');
      }
      final response = await http.get(uri);

      if (response.body.isEmpty) {
        return Left(ServerFailure('No hosts available'));
      }

      final jsonResponse = jsonDecode(response.body);

      if (response.statusCode == 200 && jsonResponse.containsKey('hosts')) {
        final hostsDataJson = jsonResponse['hosts'] as List<dynamic>;
        final List<HostEntity> hostList = hostsDataJson
            .map((hostJson) => HostModel.fromJson(hostJson).toEntity())
            .toList();

        if (hostList.isEmpty) {
          return Left(ServerFailure('No hosts available'));
        }

        return Right(hostList);
      } else if (response.statusCode == 400) {
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
