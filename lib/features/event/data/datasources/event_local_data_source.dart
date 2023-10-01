import 'dart:async';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/failure.dart';
import '../../../user/data/models/user_model.dart';
import '../models/event_model.dart';

abstract class EventLocalDataSource {
  Future<Either<Failure, String>> addDraft(EventModel event);
  Future<Either<Failure, String>> editDraft(EventModel event, String draftId);
  Future<Either<Failure, String>> deleteDraft(String draftId);
  Future<Either<Failure, List<EventModel>>> getAllDrafts();
  Future<Either<Failure, EventModel>> getDraftById(String draftId);
}

class EventLocalDataSourceImpl implements EventLocalDataSource {
  final Box<UserModel> userBox;
  EventLocalDataSourceImpl({
    required this.userBox,
  });

  @override
  Future<Either<Failure, String>> addDraft(EventModel draft) async {
    try {
      final UserModel? user = userBox.getAt(0);
      user!.events ??= [];
      user.events!.add(draft);
      userBox.putAt(0, user);

      log(user.events.toString());
      return const Right('Draft Added successfully');
    } catch (e) {
      return Left(ServerFailure('Failed to load local data'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteDraft(String draftId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> editDraft(EventModel event, String draftId) {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EventModel>>> getAllDrafts() async {
    try {
      final UserModel? user = userBox.get('userBox');
      // final result = userBox.values
      //     .map<UserModel>((e) => UserModel(id: e.id, events: e.events))
      //     .toList();
      log(user?.events?.toString() ?? '');
      // log(result[0].events.toString());
      if (user!.events == null ||
          user.events == [null] ||
          user.events?.length == 0) {
        return Left(ServerFailure('no data available'));
      }
      final drafts = user.events!.map((e) => EventModel.fromEntity(e)).toList();

      return Right(drafts);
    } catch (e) {
      return Left(ServerFailure('Failed to load local data'));
    }
  }

  @override
  Future<Either<Failure, EventModel>> getDraftById(String draftId) {
    throw UnimplementedError();
  }
}
