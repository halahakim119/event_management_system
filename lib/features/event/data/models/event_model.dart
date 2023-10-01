import '../../../host/data/models/host_model.dart';
import '../../../host/domain/entities/host_entity.dart';
import '../../../invitaions/data/models/participant_model.dart';
import '../../../invitaions/domain/entities/participant_entity.dart';
import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  EventModel({
    super.id,
    super.host,
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
    super.hostsRejected,
  });
  factory EventModel.fromEntity(EventEntity entity) {
    return EventModel(
      id: entity.id,
      host: entity.host,
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
        host: data.host,
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
      host: host,
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
    List<String>? guestsNumbers;
    List<ParticipantEntity>? guests;
    if (json['guests'] is List) {
      final guestsList = json['guests'] as List;
      if (guestsList.isNotEmpty) {
        final firstElement = guestsList.first;
        if (firstElement is String) {
          // If the first element is a string, assume all elements are strings
          guestsNumbers = List<String>.from(guestsList);
        } else if (firstElement is Map<String, dynamic>) {
          guests = guestsList
              .whereType<Map<String, dynamic>>()
              .map((guestJson) => ParticipantModel.fromJson(guestJson))
              .toList();
        }
      }
    }
    HostEntity? host;

    if (json['host'] != null) {
      host =
          HostModel.fromJson(json['host'] as Map<String, dynamic>).toEntity();
    }

// Now, you have a `host` variable that may contain a `HostModel` if it was not null in the JSON.

    // Case 3: From JSON
    return EventModel(
      id: json['id'],
      host: host,
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
      guestsNumbers: guestsNumbers,
      guests: guests,
      confirmedGuests: (json['confirmedGuests'] as List<dynamic>?)
          ?.map((confirmedGuestJson) =>
              ParticipantModel.fromJson(confirmedGuestJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic>? hostData;
    // Case 4: To JSON
    if (host != null) {
      hostData = HostModel.fromEntity(host).toJson();
    }
    return {
      'id': id,
      'host': hostData,
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
      'guests': guests
          ?.map((guest) => ParticipantModel.fromEntity(guest).toJson())
          .toList(),
      'confirmedGuests': confirmedGuests
          ?.map((confirmedGuest) =>
              ParticipantModel.fromEntity(confirmedGuest).toJson())
          .toList(),
      'postType': postType,
    };
  }
}
