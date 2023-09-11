import 'package:equatable/equatable.dart';

import '../../../user/domain/entities/user_entity.dart';

class EventEntity extends Equatable {
  final String? id;
  final String plannerId;
  final String? hostId;
  final String? hostName;
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
  final List<String>? guestsNumbers;
  final List<UserEntity>? guests;
  final List<UserEntity>? confirmedGuests;

  const EventEntity({
    this.id,
    this.hostId,
    this.hostName,
    required this.plannerId,
    required this.title,
    required this.description,
    required this.guestsNumber,
    required this.type,
    required this.postType,
    required this.startsAt,
    required this.endsAt,
    required this.startingDate,
    required this.endingDate,
    required this.adultsOnly,
    required this.food,
    required this.alcohol,
    this.dressCode,
    this.guestsNumbers,
    this.guests,
    this.confirmedGuests,
  });

  @override
  List<Object?> get props => [
        id,
        hostId,
        guestsNumbers,
        hostName,
        plannerId,
        guestsNumber,
        startsAt,
        endsAt,
        description,
        postType,
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
      ];
}
