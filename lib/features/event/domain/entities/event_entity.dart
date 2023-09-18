import 'package:equatable/equatable.dart';

import '../../../host/domain/entities/host_entity.dart';
import '../../../invitaions/domain/entities/participant_entity.dart';

class EventEntity extends Equatable {
  String? id;
  String? plannerId;
  HostEntity? host;
  String? title;
  String? description;
  int? guestsNumber;
  String? type;
  String? postType;
  String? startsAt;
  String? endsAt;
  String? startingDate;
  String? endingDate;
  bool? adultsOnly;
  bool? food;
  bool? alcohol;
  String? dressCode;
  List<String>? guestsNumbers;
  List<ParticipantEntity>? guests;
  List<ParticipantEntity>? confirmedGuests;

  EventEntity({
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
