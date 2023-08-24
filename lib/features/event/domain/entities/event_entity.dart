import 'package:equatable/equatable.dart';

import '../../../profile/domain/entities/user_entity.dart';

class EventEntity extends Equatable {
  final String? id;
  final String hostId;
  final String plannerId;
  final String title;
  final String description;
  final int guestsNumber;
  final String type;
  final String postType;
  final DateTime startsAt;
  final DateTime endsAt;
  final DateTime startingDate;
  final DateTime endingDate;
  final bool adultsOnly;
  final bool food;
  final bool alcohol;
  final String? dressCode;
  final List<UserEntity>? guests;
  final List<UserEntity>? confirmedGuests;

  const EventEntity({
    required this.id,
    required this.hostId,
    required this.plannerId,
    required this.guestsNumber,
    required this.startsAt,
    required this.endsAt,
    required this.description,
    required this.type,
    required this.title,
    required this.startingDate,
    required this.endingDate,
    required this.dressCode,
    required this.alcohol,
    required this.adultsOnly,
    required this.food,
    this.guests,
    this.confirmedGuests,
    required this.postType,
  });

  @override
  List<Object?> get props => [
        id,
        hostId,
        plannerId,
        guestsNumber,
        startsAt,
        endsAt,
        description,
        type,
        title,
        startingDate,
        endingDate,
        dressCode,
        adultsOnly,
        food,
        alcohol,
        guests,
        confirmedGuests,
        postType,
      ];
}

class HostEntity {}
