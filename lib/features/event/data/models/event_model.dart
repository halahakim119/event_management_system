import '../../../user/data/models/user_model.dart';
import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    super.id,
    super.hostId,
    super.hostName,
    super.plannerId,
    super.title,
    super.description,
    super.guestsNumber,
    super.type,
    super.postType,
    super.startsAt,
    super.endsAt,
    super.startingDate,
    super.endingDate,
    super.adultsOnly,
    super.food,
    super.alcohol,
    super.dressCode,
    super.guestsNumbers,
    super.guests,
    super.confirmedGuests,
  });
  factory EventModel.fromEntity(EventEntity entity) {
    return EventModel(
      id: entity.id,
      hostId: entity.hostId,
      hostName: entity.hostName,
      plannerId: entity.plannerId,
      title: entity.title,
      description: entity.description,
      guestsNumber: entity.guestsNumber,
      type: entity.type,
      postType: entity.postType,
      startsAt: entity.startsAt,
      endsAt: entity.endsAt,
      startingDate: entity.startingDate,
      endingDate: entity.endingDate,
      adultsOnly: entity.adultsOnly,
      food: entity.food,
      alcohol: entity.alcohol,
      dressCode: entity.dressCode,
      guestsNumbers: entity.guestsNumbers,
      guests: entity.guests,
      confirmedGuests: entity.confirmedGuests,
    );
  }
  factory EventModel.from(dynamic data) {
    if (data is EventEntity) {
      // Case 1: From Entity
      return EventModel(
        id: data.id,
        hostId: data.hostId,
        hostName: data.hostName,
        plannerId: data.plannerId,
        title: data.title,
        description: data.description,
        guestsNumber: data.guestsNumber,
        type: data.type,
        postType: data.postType,
        startsAt: data.startsAt,
        endsAt: data.endsAt,
        startingDate: data.startingDate,
        endingDate: data.endingDate,
        adultsOnly: data.adultsOnly,
        food: data.food,
        alcohol: data.alcohol,
        dressCode: data.dressCode,
        guestsNumbers: data.guestsNumbers,
        guests: data.guests,
        confirmedGuests: data.confirmedGuests,
      );
    } else if (data is Map<String, dynamic>) {
      // Case 2: From JSON
      return EventModel.fromJson(data);
    } else {
      throw ArgumentError("Unsupported data type for conversion");
    }
  }

  EventEntity toEntity() {
    return EventEntity(
      id: id,
      hostId: hostId,
      hostName: hostName,
      title: title,
      description: description,
      guestsNumber: guestsNumber,
      type: type,
      postType: postType,
      startsAt: startsAt,
      endsAt: endsAt,
      startingDate: startingDate,
      endingDate: endingDate,
      adultsOnly: adultsOnly,
      food: food,
      alcohol: alcohol,
      dressCode: dressCode,
      guestsNumbers: guestsNumbers,
      guests: guests,
      confirmedGuests: confirmedGuests,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) {
    // Case 3: From JSON
    return EventModel(
      id: json['id'],
      hostId: json['hostId'],
      plannerId: json['plannerId'],
      guestsNumber: json['guestsNumber'],
      startsAt: json['startsAt'],
      endsAt: json['endsAt'],
      description: json['description'],
      type: json['type'],
      postType: json['postType'],
      title: json['title'],
      startingDate: json['startingDate'],
      endingDate: json['endingDate'],
      dressCode: json['dressCode'],
      alcohol: json['alcohol'],
      adultsOnly: json['adultsOnly'],
      food: json['food'],
      guestsNumbers: List<String>.from(json['guests'] ?? []),
      guests: (json['guests'] as List<dynamic>?)
          ?.map((guestJson) => UserModel.fromJson(guestJson))
          .toList(),
      confirmedGuests: (json['confirmedGuests'] as List<dynamic>?)
          ?.map((confirmedGuestJson) => UserModel.fromJson(confirmedGuestJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    // Case 4: To JSON
    return {
      'id': id,
      'hostId': hostId,
      'plannerId': plannerId,
      'guestsNumber': guestsNumber,
      'startsAt': startsAt,
      'endsAt': endsAt,
      'description': description,
      'type': type,
      'title': title,
      'startingDate': startingDate,
      'endingDate': endingDate,
      'dressCode': dressCode,
      'alcohol': alcohol,
      'adultsOnly': adultsOnly,
      'food': food,
      'guests':
          guests?.map((guest) => UserModel.fromEntity(guest).toJson()).toList(),
      'confirmedGuests': confirmedGuests
          ?.map(
              (confirmedGuest) => UserModel.fromEntity(confirmedGuest).toJson())
          .toList(),
      'postType': postType,
    };
  }
}
