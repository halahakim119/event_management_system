import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../event/data/models/event_model.dart';
import '../../../event/data/models/init_model.dart';
import '../../../event/data/models/request_model.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../../../event/domain/entities/init_entity.dart';
import '../../../event/domain/entities/request_entity.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<Either<Failure, UserModel>> getUser(String id);
}

class UserDataSourceImpl implements UserDataSource {
  final Box<UserModel> userDataBox;

  UserDataSourceImpl({
    required this.userDataBox,
  });

  @override
  Future<Either<Failure, UserModel>> getUser(String id) async {
    try {
      final IO.Socket socket = IO.io(
        'http://35.180.62.182/',
        IO.OptionBuilder().setTransports(['websocket']).build(),
      );

      final connectionCompleter = Completer<void>(); // Completer for connection

      socket.onConnect((data) {
        log(data.toString());
        log(socket.id!);
        log('Connected to socket');

        // Send the request with your ID and enable acknowledgment
        socket.emitWithAck("join", id, ack: (data) async {
          log('Join event acknowledgment: $data');
          final responseJson = data as Map<String, dynamic>;

          // Extract fields from the response
          final name = responseJson['name'];
          final phoneNumber = responseJson['phoneNumber'];
          final token = responseJson['token'];
          final userId = responseJson['id'];
          final List<dynamic> requestsData = responseJson['requests'];
          final List<dynamic> initData = responseJson['init'];
          final List<dynamic> attendanceData = responseJson['attendance'];
          final List<dynamic> eventsPlannedData = responseJson['eventsPlanned'];

          final List<RequestEntity> requests = requestsData.map((data) {
            return RequestModel.fromJson(
                data); // Assuming there's a method to convert JSON to RequestEntity
          }).toList();

          final List<InitEntity> init = initData.map((data) {
            return InitModel.fromJson(
                data); // Assuming there's a method to convert JSON to InitEntity
          }).toList();

          final List<EventEntity> attendance = attendanceData.map((data) {
            return EventModel.fromJson(
                data); // Assuming there's a method to convert JSON to EventEntity
          }).toList();

          final List<EventEntity> eventsPlanned = eventsPlannedData.map((data) {
            return EventModel.fromJson(
                data); // Assuming there's a method to convert JSON to EventEntity
          }).toList();

          // Create a UserModel instance
          final userModel = UserModel(
            province: '',
            following: [],
            name: name,
            phoneNumber: phoneNumber,
            token: token,
            requests: requests,
            inits: init,
            attendance: attendance,
            events: eventsPlanned,
            id: userId,
          );

          socket.disconnect();
          log(userModel.phoneNumber.toString());
          return Right(userModel);
        });

        connectionCompleter.complete(); // Complete the connection Completer
      });

      await connectionCompleter
          .future; // Wait for the connection to be established

      socket.on('error', (error) {
        log('Socket error: $error');
        socket.disconnect();
        return Left(ApiException('Socket error'));
      });

      socket.onDisconnect((_) {
        log('Socket disconnected');
      });

      return Left(ServerFailure('Failed to communicate with the server'));
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
