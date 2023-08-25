import '../../../user/domain/entities/user_entity.dart';

// ignore: must_be_immutable
class UserProfileModel extends UserEntity {
  UserProfileModel({
    required String id,
    required String name,
    required String phoneNumber,
    required String token,
    required String province,
  }) : super(
            id: id,
            name: name,
            phoneNumber: phoneNumber,
            token: token,
            province: province);

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
      province: json['province'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'token': token,
      'province': province,
    };
  }

  UserProfileModel fromEntity(UserEntity entity) {
    return UserProfileModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      token: entity.token,
      province: entity.province,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        token: token,
        province: province);
  }
}
