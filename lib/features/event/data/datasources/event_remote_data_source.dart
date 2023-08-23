import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class EventRemoteDataSource {
  Future<Either<Failure, Map<String, String>>> getEventById(
      {required String id});
  Future<Either<Failure, Map<String, String>>> getAllEvents();

  Future<Either<Failure, Unit>> createEvent({
    required String title,
    required String description,
    required String seatNum,
    required DateTime startingDate,
    required DateTime endingDate,
    required DateTime startsAt,
    required DateTime endsAt,
    required String eventType,
    required String postType,
    bool adultsOnly,
    bool food,
    bool alcohol,
  });

  Future<Either<Failure, Unit>> updateEvent();

  Future<Either<Failure, Map<String, String>>> deleteEvent(
      {required String id});
}

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  @override
  Future<Either<Failure, Unit>> createEvent(
      {
      required String title,
      required String description,
      required String seatNum,
      required DateTime startingDate,
      required DateTime endingDate,
      required DateTime startsAt,
      required DateTime endsAt,
      required String eventType,
      required String postType,
      bool? adultsOnly,
      bool? food,
      bool? alcohol}) {
 
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, String>>> deleteEvent(
      {required String id}) {
    // TODO: implement deleteEvent
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, String>>> getAllEvents() {
    // TODO: implement getAllEvents
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Map<String, String>>> getEventById(
      {required String id}) {
    // TODO: implement getEventById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateEvent() {
    // TODO: implement updateEvent
    throw UnimplementedError();
  }
}
