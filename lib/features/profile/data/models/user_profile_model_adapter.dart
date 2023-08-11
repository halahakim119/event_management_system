import 'package:hive/hive.dart';

import 'user_profile_model.dart';

class UserProfileModelAdapter extends TypeAdapter<UserProfileModel> {
  @override
  final int typeId = 0;

  @override
  UserProfileModel read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return UserProfileModel(
        id: fields[0] as String,
        name: fields[1] as String,
        phoneNumber: fields[2] as String,
        token: fields[3] as String,
        province: fields[4] as String);
  }

  @override
  void write(BinaryWriter writer, UserProfileModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.phoneNumber)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.province);
  }
}
