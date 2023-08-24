import '../../domain/entities/request_entity.dart';

class RequestModel extends RequestEntity {
  const RequestModel({
    required String id,
    required String plannerId,
    required String hostId,
    required String hostName,
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
    List<String>? guests,
  }) : super(
          id: id,
          plannerId: plannerId,
          hostId: hostId,
          hostName: hostName,
          guestsNumber: guestsNumber,
          startsAt: startsAt,
          endsAt: endsAt,
          description: description,
          type: type,
          postType: postType,
          title: title,
          startingDate: startingDate,
          endingDate: endingDate,
          dressCode: dressCode,
          alcohol: alcohol,
          adultsOnly: adultsOnly,
          food: food,
          guests: guests,
        );

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      id: json['id'],
      plannerId: json['plannerId'],
      hostId: json['hostId'],
      hostName: json['hostName'],
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
      guests: List<String>.from(json['guests']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'plannerId': plannerId,
      'hostId': hostId,
      'hostName': hostName,
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
      'guests': guests,
    };
  }
}
