import '../../../user/data/models/user_model.dart';
import '../../../user/domain/entities/user_entity.dart';
import '../../domain/entities/event_entity.dart';

class EventModel extends EventEntity {
  const EventModel({
    required String? id,
    required String hostId,
    required String plannerId,
    required String title,
    required String description,
    required int guestsNumber,
    required String type,
    required String postType,
    required DateTime startsAt,
    required DateTime endsAt,
    required DateTime startingDate,
    required DateTime endingDate,
    required bool adultsOnly,
    required bool food,
    required bool alcohol,
    required String? dressCode,
    List<UserEntity>? guests,
    List<UserEntity>? confirmedGuests,
  }) : super(
          id: id,
          hostId: hostId,
          plannerId: plannerId,
          guestsNumber: guestsNumber,
          startsAt: startsAt,
          endsAt: endsAt,
          description: description,
          type: type,
          title: title,
          startingDate: startingDate,
          endingDate: endingDate,
          dressCode: dressCode,
          alcohol: alcohol,
          adultsOnly: adultsOnly,
          food: food,
          guests: guests,
          confirmedGuests: confirmedGuests,
          postType: postType,
        );

  factory EventModel.fromJson(Map<String, dynamic> json) {
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

  Map<String, dynamic> toJson() {
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
}
