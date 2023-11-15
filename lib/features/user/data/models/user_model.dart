import 'package:hive_flutter/hive_flutter.dart';

import '../../../event/data/models/event_model.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../../../invitaions/data/models/invite_model.dart';
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    super.id,
    super.token,                                                                                   
    super.name,
    super.phoneNumber,
    super.province,
    super.FCMtokens,
    super.following,
    super.events,
    super.invites,
  });

  static UserModel? getUserData() {
    UserModel? user;
    final userBox = Hive.box<UserModel>('userBox');
    if (userBox.isNotEmpty) {
      user = userBox.getAt(0);
    }
    return user;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    List<EventEntity>? events = (json['eventsPlanned'] as List<dynamic>?)
            ?.map((e) => EventModel.fromJson(e).toEntity())
            .toList() ??
        [];
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'],
      phoneNumber: json['phoneNumber'] ?? '',
      token: json['token'] ?? '',
      province: json['province'] ?? '',
      FCMtokens: List<String>.from(json['FCMtokens'] ?? []),
      following: (json['following'] as List<dynamic>?)
              ?.map((e) => UserModel.fromJson(e).toEntity())
              .toList() ??
          [],
      events: events,
      invites: (json['invites'] as List<dynamic>?)
              ?.map((e) => InviteModel.fromJson(e).toEntity())
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
              ?.map((event) => EventModel.fromEntity(event).toJson())
              .toList() ??
          [],
      'invites': invites
              ?.map((invites) => InviteModel.fromEntity(invites).toJson())
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
      invites: entity.invites,
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
      invites: invites,
    );
  }
}
