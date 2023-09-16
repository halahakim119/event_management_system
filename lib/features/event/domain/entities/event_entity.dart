import 'package:equatable/equatable.dart';

import '../../../host/domain/entities/host_entity.dart';
import '../../../invitaions/domain/entities/participant_entity.dart';

class EventEntity extends Equatable {
  final String? id;
  final String? plannerId;
  final HostEntity? host;

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
  final List<ParticipantEntity>? guests;
  final List<ParticipantEntity>? confirmedGuests;

  const EventEntity({
    this.id,
    this.host,
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
        host,
        guestsNumbers,
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
