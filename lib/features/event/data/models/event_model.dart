import '../../../user/data/models/user_model.dart';
import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    super.id,
    super.hostId,
    super.hostName,
    required super.plannerId,
    required super.title,
    required super.description,
    required super.guestsNumber,
    required super.type,
    required super.postType,
    required super.startsAt,
    required super.endsAt,
    required super.startingDate,
    required super.endingDate,
    required super.adultsOnly,
    required super.food,
    required super.alcohol,
    required super.dressCode,
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

  factory EventModel.fromJsonEvent(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      hostId: json['hostId'],
      plannerId: json['plannerId'],
      guestsNumber: json['guestsNumber'],
      startsAt: DateTime.parse(json['startsAt']),
      endsAt: DateTime.parse(json['endsAt']),
      description: json['description'],
      type: json['type'],
      title: json['title'],
      startingDate: DateTime.parse(json['startingDate']),
      endingDate: DateTime.parse(json['endingDate']),
      dressCode: json['dressCode'],
      alcohol: json['alcohol'],
      adultsOnly: json['adultsOnly'],
      food: json['food'],
      guests: (json['guests'] as List<dynamic>)
          .map((guestJson) => UserModel.fromJson(guestJson))
          .toList(),
      confirmedGuests: (json['confirmedGuests'] as List<dynamic>)
          .map((confirmedGuestJson) => UserModel.fromJson(confirmedGuestJson))
          .toList(),
      postType: json['postType'],
    );
  }

  Map<String, dynamic> toJsonEvent() {
    return {
      'id': id,
      'hostId': hostId,
      'plannerId': plannerId,
      'guestsNumber': guestsNumber,
      'startsAt': startsAt.toIso8601String(),
      'endsAt': endsAt.toIso8601String(),
      'description': description,
      'type': type,
      'title': title,
      'startingDate': startingDate.toIso8601String(),
      'endingDate': endingDate.toIso8601String(),
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

  factory EventModel.fromJsonInit(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      plannerId: json['plannerId'],
      guestsNumber: json['guestsNumber'],
      startsAt: DateTime.parse(json['startsAt']),
      endsAt: DateTime.parse(json['endsAt']),
      description: json['description'],
      type: json['type'],
      postType: json['postType'],
      title: json['title'],
      startingDate: DateTime.parse(json['startingDate']),
      endingDate: DateTime.parse(json['endingDate']),
      dressCode: json['dressCode'],
      alcohol: json['alcohol'],
      adultsOnly: json['adultsOnly'],
      food: json['food'],
      guestsNumbers: List<String>.from(json['guests']),
    );
  }

  Map<String, dynamic> toJsonInit() {
    return {
      'plannerId': plannerId,
      'guestsNumber': guestsNumber,
      'startsAt': startsAt.toIso8601String(),
      'endsAt': endsAt.toIso8601String(),
      'description': description,
      'type': type,
      'postType': postType,
      'title': title,
      'startingDate': startingDate.toIso8601String(),
      'endingDate': endingDate.toIso8601String(),
      'dressCode': dressCode,
      'alcohol': alcohol,
      'adultsOnly': adultsOnly,
      'food': food,
    };
  }

  factory EventModel.fromJsonRequest(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      plannerId: json['plannerId'],
      hostId: json['hostId'],
      guestsNumber: json['guestsNumber'],
      startsAt: DateTime.parse(json['startsAt']),
      endsAt: DateTime.parse(json['endsAt']),
      description: json['description'],
      type: json['type'],
      postType: json['postType'],
      title: json['title'],
      startingDate: DateTime.parse(json['startingDate']),
      endingDate: DateTime.parse(json['endingDate']),
      dressCode: json['dressCode'],
      alcohol: json['alcohol'],
      adultsOnly: json['adultsOnly'],
      food: json['food'],
      guestsNumbers: List<String>.from(json['guests']),
    );
  }

  Map<String, dynamic> toJsonRequest() {
    return {
      'adultsOnly': adultsOnly,
      'id': id,
      'alcohol': alcohol,
      'description': description,
      'dressCode': dressCode,
      'endingDate': endingDate.toIso8601String(),
      'endsAt': endsAt.toIso8601String(),
      'food': food,
      'startingDate': startingDate.toIso8601String(),
      'startsAt': startsAt.toIso8601String(),
      'guestsNumber': guestsNumber,
      'postType': postType,
      'title': title,
      'type': type,
      'plannerId': plannerId,
      'hostId': hostId,
    };
  }
}
