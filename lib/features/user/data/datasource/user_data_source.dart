// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
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
      final socket = IO.io('http://35.180.62.182', <String, dynamic>{
        'transports': ['websocket'],
      });

      socket.connect();

      socket.onConnect((_) {
        log('Connected to socket');
        socket.emit('join');
        socket.emit('request', {'id': id});
      });

      final userCompleter = Completer<UserModel>();

      socket.on('response', (data) async {
        final userJson = data as Map<String, dynamic>;
        final userData = UserModel.fromJson(userJson);
        await userDataBox.put('userDataBox', userData);
        userCompleter.complete(userData);
        socket.disconnect();
      });

      socket.on('error', (error) {
        log('Socket error: $error');
        userCompleter.completeError(ApiException('Socket error'));
        socket.disconnect();
      });

      socket.onDisconnect((_) {
        log('Socket disconnected');
      });

      final userData = await userCompleter.future;
      return Right(userData);
    } catch (e) {
      return Left(ServerFailure('Failed to communicate with the server'));
    }
  }
}
