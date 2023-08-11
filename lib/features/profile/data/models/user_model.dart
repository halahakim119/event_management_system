import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String name,
    required String phoneNumber,
    required String token,
    required String province,
    String? password,
    List<Map<String, dynamic>>? following,
    List<Map<String, dynamic>>? events,
  }) : super(
          id: id,
          name: name,
          phoneNumber: phoneNumber,
          token: token,
          province: province,
          password: password,
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
      password: json['password'],
      following: List<Map<String, dynamic>>.from(json['following']),
      events: List<Map<String, dynamic>>.from(json['events']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'token': token,
      'province': province,
      'password': password,
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
      password: entity.password,
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
      password: password,
      following: following,
      events: events,
    );
  }
}
