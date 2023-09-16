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
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory ParticipantModel.fromEntity(ParticipantEntity entity) {
    return ParticipantModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
    );
  }
  ParticipantEntity toEntity() {
    return ParticipantEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
    );
  }
}
