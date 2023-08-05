import 'package:hive/hive.dart';

import 'user_model.dart';

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0; // Assign a unique ID for the adapter

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
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    // Implement the write method to convert UserModel object to binary data
    writer
      ..writeByte(5) // Number of fields in the UserModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, name
      ..write(obj.name)
      ..writeByte(2) // Field index 2, phoneNumber
      ..write(obj.phoneNumber)
      ..writeByte(3) // Field index 3, token
      ..write(obj.token)
      ..writeByte(4) // Field index 4, province
      ..write(obj.province);
  }
}
