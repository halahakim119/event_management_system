import 'package:hive/hive.dart';

import '../../../event/data/models/event_model.dart';
import '../models/user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 3; // Assign a unique ID for the adapter
  @override
  UserModel read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    // Check if fields[5], fields[6], and fields[7] are not null and are lists,
    // then cast them to List<dynamic>, otherwise, set them to an empty list
    final following = fields[5] is List<dynamic>
        ? (fields[5] as List<dynamic>)
            .map((e) => UserModel.fromJson(e))
            .toList()
        : null;
    final events = fields[6] is List<Map<String, dynamic>>
        ? (fields[6] as List<Map<String, dynamic>>)
            .map((e) {
              return EventModel.fromJson(e).toEntity();
            })
            // ignore: unnecessary_null_comparison
            .where((event) => event != null)
            .toList()
        : null;

    final invites = fields[7] is List<dynamic>
        ? (fields[7] as List<dynamic>)
            .map((e) => EventModel.fromJson(e))
            .toList()
        : null;

    // Check if fields[8] is not null and is a list, then cast it to List<String>
    final fcmTokens = fields[8] is List<String>
        ? (fields[8] as List<dynamic>).cast<String>()
        : <String>[];

    return UserModel(
      id: fields[0] as String,
      name: fields[1] as String,
      phoneNumber: fields[2] as String,
      token: fields[3] as String,
      province: fields[4] as String,
      following: following,
      events: events,
      invites: invites,
      FCMtokens: fcmTokens,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(9) // Number of fields in the UserModel class
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
              .toList() ??
          [])
      ..writeByte(6) // Field index 6, events
      ..write(obj.events
              ?.map((events) => EventModel.fromEntity(events).toJson())
              .toList() ??
          [])
      ..writeByte(7) // Field index 7, invites
      ..write(obj.invites
              ?.map((invites) => EventModel.fromEntity(invites).toJson())
              .toList() ??
          [])
      ..writeByte(8) // Field index 8, FCMtokens
      ..write(obj.FCMtokens);
  }
}
