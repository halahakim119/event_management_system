import '../../domain/entities/init_entity.dart';

class InitModel extends InitEntity {
  const InitModel({
    String? id,
    required String plannerId,
    required int guestsNumber,
    required DateTime startsAt,
    required DateTime endsAt,
    required String description,
    required String type,
    required String postType,
    required String title,
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
          postType: postType,
        );

  factory InitModel.fromJson(Map<String, dynamic> json) {
    return InitModel(
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
      guests: List<String>.from(json['guests']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
      'guests': guests,
    };
  }

  InitModel.fromEntity(InitEntity entity)
      : super(
          id: entity.id,
          plannerId: entity.plannerId,
          guestsNumber: entity.guestsNumber,
          startsAt: entity.startsAt,
          endsAt: entity.endsAt,
          description: entity.description,
          type: entity.type,
          title: entity.title,
          startingDate: entity.startingDate,
          endingDate: entity.endingDate,
          dressCode: entity.dressCode,
          alcohol: entity.alcohol,
          adultsOnly: entity.adultsOnly,
          food: entity.food,
          guests: entity.guests,
          postType: entity.postType,
        );
  InitEntity toEntity() {
    return InitEntity(
      id: id,
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
      postType: postType,
    );
  }
}
