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
      startsAt: json['startsAt'],
      endsAt: json['endsAt'],
      description: json['description'],
      type: json['type'],
      title: json['title'],
      startingDate: json['startingDate'],
      endingDate: json['endingDate'],
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

  factory EventModel.fromJsonInit(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
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
      guestsNumbers: List<String>.from(json['guests']),
    );
  }

  Map<String, dynamic> toJsonInit() {
    return dressCode == null
        ? {
            'plannerId': plannerId,
            'guestsNumber': guestsNumber,
            'startsAt': startsAt,
            'endsAt': endsAt,
            'description': description,
            'type': type,
            'postType': postType,
            'title': title,
            'startingDate': startingDate,
            'endingDate': endingDate,
            'alcohol': alcohol,
            'adultsOnly': adultsOnly,
            'food': food,
          }
        : {
            'plannerId': plannerId,
            'guestsNumber': guestsNumber,
            'startsAt': startsAt,
            'endsAt': endsAt,
            'description': description,
            'type': type,
            'postType': postType,
            'title': title,
            'startingDate': startingDate,
            'endingDate': endingDate,
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
      'endingDate': endingDate,
      'endsAt': endsAt,
      'food': food,
      'startingDate': startingDate,
      'startsAt': startsAt,
      'guestsNumber': guestsNumber,
      'postType': postType,
      'title': title,
      'type': type,
      'plannerId': plannerId,
      'hostId': hostId,
    };
  }
}
