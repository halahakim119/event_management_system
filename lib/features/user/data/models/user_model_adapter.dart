import 'package:hive/hive.dart';

import '../../../event/data/models/event_model.dart';
import '../../../event/data/models/init_model.dart';
import '../../../event/data/models/request_model.dart';
import '../models/user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 5; // Assign a unique ID for the adapter

  @override
  UserModel read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return UserModel(
      id: fields[0] as String,
      name: fields[1] as String,
      phoneNumber: fields[2] as String,
      token: fields[3] as String,
      province: fields[4] as String,
      following: (fields[5] as List<dynamic>)
          .map((following) => UserModel.fromJson(following))
          .toList(),
      events: (fields[6] as List<dynamic>)
          .map((events) => EventModel.fromJson(events))
          .toList(),
      requests: (fields[7] as List<dynamic>)
          .map((requests) => RequestModel.fromJson(requests))
          .toList(),
      inits: (fields[8] as List<dynamic>)
          .map((inits) => InitModel.fromJson(inits))
          .toList(),
      attendance: (fields[9] as List<dynamic>)
          .map((attendance) => EventModel.fromJson(attendance))
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(10) // Number of fields in the UserModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, name
      ..write(obj.name)
      ..writeByte(2) // Field index 2, phoneNumber
      ..write(obj.phoneNumber)
      ..writeByte(3) // Field index 3, token
      ..write(obj.token)
      ..writeByte(4) // Field index 4, province
      ..write(obj.province)
      ..writeByte(5) // Field index 5, following
      ..write(obj.following
          ?.map((following) => UserModel.fromEntity(following).toJson())
          .toList())
      ..writeByte(6) // Field index 6, events
      ..write(obj.events
          ?.map((events) => EventModel.fromEntity(events).toJson())
          .toList())
      ..writeByte(7) // Field index 7, requests
      ..write(obj.requests
          ?.map((requests) => RequestModel.fromEntity(requests).toJson())
          .toList())
      ..writeByte(8) // Field index 8, inits
      ..write(obj.inits
          ?.map((inits) => InitModel.fromEntity(inits).toJson())
          .toList())
      ..writeByte(9) // Field index 9, attendance
      ..write(obj.attendance
          ?.map((attendance) => EventModel.fromEntity(attendance).toJson())
          .toList());
  }
}
