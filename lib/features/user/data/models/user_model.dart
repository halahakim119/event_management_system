import 'package:hive_flutter/hive_flutter.dart';

import '../../../event/data/models/event_model.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../../domain/entities/user_entity.dart';

// ignore: must_be_immutable
class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String token,
    required String name,
    required String phoneNumber,
    required String province,
    required List<String> FCMtokens,
    List<UserEntity>? following,
    List<EventEntity>? events,
    List<EventEntity>? attendance,
  }) : super(
          FCMtokens: FCMtokens,
          id: id,
          name: name,
          phoneNumber: phoneNumber,
          token: token,
          province: province,
          following: following,
          events: events,
          attendance: attendance,
        );

  static UserModel? getUserData() {
    UserModel? user;
    final userBox = Hive.box<UserModel>('userBox');
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
    return user;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
      province: json['province'],
      FCMtokens: List<String>.from(json['FCMtokens']),
      following: (json['following'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e))
              .toList() ??
          [],
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => EventModel.fromJsonEvent(e))
              .toList() ??
          [],
      attendance: (json['attendance'] as List<dynamic>?)
              ?.map((e) => EventModel.fromJsonEvent(e))
              .toList() ??
          [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'token': token,
      'province': province,
      'FCMtokens': FCMtokens,
      'following': following
              ?.map((following) => UserModel.fromEntity(following).toJson())
              .toList() ??
          [],
      'events': events
              ?.map((event) => EventModel.fromEntity(event).toJsonEvent())
              .toList() ??
          [],
      'attendance': attendance
              ?.map((attendance) =>
                  EventModel.fromEntity(attendance).toJsonEvent())
              .toList() ??
          [],
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      FCMtokens: entity.FCMtokens,
      phoneNumber: entity.phoneNumber,
      token: entity.token,
      province: entity.province,
      following: entity.following,
      events: entity.events,
      attendance: entity.attendance,
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
      FCMtokens: FCMtokens,
      attendance: attendance,
    );
  }
}
