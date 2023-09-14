import '../../domain/entities/participant_entity.dart';

class ParticipantModel extends ParticipantEntity {
  ParticipantModel(
      {required super.id, required super.name, required super.phoneNumber});

  factory ParticipantModel.fromJson(Map<String, dynamic> json) {
    return ParticipantModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }
}
