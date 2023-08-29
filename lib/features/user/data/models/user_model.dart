import '../../../event/data/models/event_model.dart';
import '../../../event/data/models/init_model.dart';
import '../../../event/data/models/request_model.dart';
import '../../../event/domain/entities/event_entity.dart';
import '../../../event/domain/entities/init_entity.dart';
import '../../../event/domain/entities/request_entity.dart';
import '../../domain/entities/user_entity.dart';

// ignore: must_be_immutable
class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String token,
    required String name,
    required String phoneNumber,
    required String province,
    List<UserEntity>? following,
    List<EventEntity>? events,
    List<RequestEntity>? requests,
    List<InitEntity>? inits,
    List<EventEntity>? attendance,
  }) : super(
          id: id,
          name: name,
          phoneNumber: phoneNumber,
          token: token,
          province: province,
          following: following,
          events: events,
          requests: requests,
          inits: inits,
          attendance: attendance,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      token: json['token'],
      province: json['province'],
      following: (json['following'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e))
          .toList(),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => EventModel.fromJson(e))
          .toList(),
      requests: (json['requests'] as List<dynamic>?)
          ?.map((e) => RequestModel.fromJson(e))
          .toList(),
      inits: (json['inits'] as List<dynamic>?)
          ?.map((e) => InitModel.fromJson(e))
          .toList(),
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map((e) => EventModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'token': token,
      'province': province,
      'following': following
          ?.map((following) => UserModel.fromEntity(following).toJson())
          .toList(),
      'events': events
          ?.map((events) => EventModel.fromEntity(events).toJson())
          .toList(),
      'requests': requests
          ?.map((requests) => RequestModel.fromEntity(requests).toJson())
          .toList(),
      'inits':
          inits?.map((inits) => InitModel.fromEntity(inits).toJson()).toList(),
      'attendance': attendance
          ?.map((attendance) => EventModel.fromEntity(attendance).toJson())
          .toList(),
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
      requests: entity.requests,
      inits: entity.inits,
      attendance: entity.attendance,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      token: entity.token,
      province: entity.province,
      following: entity.following,
      events: entity.events,
      requests: entity.requests,
      inits: entity.inits,
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
      requests: requests,
      inits: inits,
      attendance: attendance,
    );
  }
}
