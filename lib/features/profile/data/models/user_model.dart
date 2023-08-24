import '../../../event/domain/entities/event_entity.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String token,
    required String name,
    required String phoneNumber,
    required String province,
    List<HostEntity>? following,
    List<EventEntity>? events,
  }) : super(
          id: id,
          name: name,
          phoneNumber: phoneNumber,
          token: token,
          province: province,
          following: following,
          events: events,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
      province: json['province'],
      following: List<HostEntity>.from(json['following']),
      events: List<EventEntity>.from(json['events']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'token': token,
      'province': province,
      'following': following,
      'events': events,
    };
  }

  UserModel fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      token: entity.token,
      province: entity.province,
      following: entity.following,
      events: entity.events,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      phoneNumber: phoneNumber,
      token: token,
      province: province,
      following: following,
      events: events,
    );
  }
}
