import 'package:equatable/equatable.dart';

import '../../../profile/domain/entities/user_entity.dart';

class RequestEntity extends Equatable {
  final String id;
  final UserEntity planner;
  final String plannerId;
  final String hostId;
  final int guestsNumber;
  final DateTime startsAt;
  final DateTime endsAt;
  final String description;
  final String type;
  final String requestType;
  final String eventId;
  final String title;
  final DateTime startingDate;
  final DateTime endingDate;
  final String? dressCode;
  final bool? adultsOnly;
  final bool? food;
  final bool? alcohol;
  final List<String>? guests;
  final String hostName;

  const RequestEntity({
    required this.id,
    required this.planner,
    required this.plannerId,
    required this.hostId,
    required this.guestsNumber,
    required this.startsAt,
    required this.endsAt,
    required this.description,
    required this.type,
    required this.requestType,
    required this.eventId,
    required this.title,
    required this.startingDate,
    required this.endingDate,
    this.dressCode,
    this.adultsOnly,
    this.food,
    this.alcohol,
    this.guests,
    required this.hostName,
  });

  @override
  List<Object?> get props => [
        id,
        planner,
        plannerId,
        hostId,
        guestsNumber,
        startsAt,
        endsAt,
        description,
        type,
        requestType,
        eventId,
        title,
        startingDate,
        endingDate,
        dressCode,
        adultsOnly,
        food,
        alcohol,
        guests,
        hostName,
      ];
}
