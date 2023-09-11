import '../../../user/domain/entities/user_entity.dart';

// ignore: must_be_immutable
class UserProfileModel extends UserEntity {
  UserProfileModel(
      {required String id,
      required String name,
      required String phoneNumber,
      required String token,
      required String province,
      required List<String> FCMtokens})
      : super(
            FCMtokens: FCMtokens,
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
      FCMtokens: List<String>.from(json['FCMtokens']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'token': token,
      'province': province,
      'FCMtokens': FCMtokens
    };
  }

  UserProfileModel fromEntity(UserEntity entity) {
    return UserProfileModel(
        id: entity.id,
        name: entity.name,
        phoneNumber: entity.phoneNumber,
        token: entity.token,
        province: entity.province,
        FCMtokens: entity.FCMtokens);
  }

  UserEntity toEntity() {
    return UserEntity(
        id: id,
        name: name,
        phoneNumber: phoneNumber,
        token: token,
        province: province,
        FCMtokens: FCMtokens);
  }
}
