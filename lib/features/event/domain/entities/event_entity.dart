import 'package:equatable/equatable.dart';

import '../../../user/domain/entities/user_entity.dart';

class EventEntity extends Equatable {
  final String? id;
  final String? plannerId;
  final String? hostId;
  final String? hostName;
  final String? title;
  final String? description;
  final int? guestsNumber;
  final String? type;
  final String? postType;
  final String? startsAt;
  final String? endsAt;
  final String? startingDate;
  final String? endingDate;
  final bool? adultsOnly;
  final bool? food;
  final bool? alcohol;
  final String? dressCode;
  final List<String>? guestsNumbers;
  final List<UserEntity>? guests;
  final List<UserEntity>? confirmedGuests;

  const EventEntity({
    this.id,
    this.hostId,
    this.hostName,
    this.plannerId,
    this.title,
    this.description,
    this.guestsNumber,
    this.type,
    this.postType,
    this.startsAt,
    this.endsAt,
    this.startingDate,
    this.endingDate,
    this.adultsOnly,
    this.food,
    this.alcohol,
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
