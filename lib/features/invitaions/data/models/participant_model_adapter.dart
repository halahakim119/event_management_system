import 'package:hive/hive.dart';

import 'participant_model.dart';

class ParticipantModelAdapter extends TypeAdapter<ParticipantModel> {
  @override
  final int typeId = 4; // Assign a unique ID for the adapter
  @override
  ParticipantModel read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return ParticipantModel(
      id: fields[0] as String?,
      name: fields[1] as String?,
      phoneNumber: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ParticipantModel obj) {
    writer
      ..writeByte(3) // Number of fields in the UserModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, name
      ..write(obj.name)
      ..writeByte(2) // Field index 2, phoneNumber
      ..write(obj.phoneNumber);
  }
}
