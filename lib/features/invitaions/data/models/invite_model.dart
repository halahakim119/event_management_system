import '../../domain/entities/invite_entity.dart';

class InviteModel extends InviteEntity {
  InviteModel({
     super.id,
     super.title,
     super.type,
  });

  factory InviteModel.fromJson(Map<String, dynamic> json) {
    return InviteModel(
      id: json['id'],
      title: json['title'],
      type: json['type'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
    };
  }

  factory InviteModel.fromEntity(InviteEntity entity) {
    return InviteModel(
      id: entity.id,
      title: entity.title,
      type: entity.type,
    );
  }
  InviteEntity toEntity() {
    return InviteEntity(
      id: id,
      title: title,
      type: type,
    );
  }
}
