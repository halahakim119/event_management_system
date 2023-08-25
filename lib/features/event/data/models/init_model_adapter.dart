import 'package:hive/hive.dart';

import '../models/init_model.dart';

class InitModelAdapter extends TypeAdapter<InitModel> {
  @override
  final int typeId = 3; // Assign a unique ID for the adapter

  @override
  InitModel read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return InitModel(
      id: fields[0] as String?,
      plannerId: fields[1] as String,
      guestsNumber: fields[2] as int,
      startsAt: DateTime.parse(fields[3] as String),
      endsAt: DateTime.parse(fields[4] as String),
      description: fields[5] as String,
      type: fields[6] as String,
      postType: fields[7] as String,
      title: fields[8] as String,
      startingDate: DateTime.parse(fields[9] as String),
      endingDate: DateTime.parse(fields[10] as String),
      adultsOnly: fields[11] as bool,
      food: fields[12] as bool,
      alcohol: fields[13] as bool,
      dressCode: fields[14] as String?,
      guests: (fields[15] as List<dynamic>).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, InitModel obj) {
    writer
      ..writeByte(16) // Number of fields in the InitModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, plannerId
      ..write(obj.plannerId)
      ..writeByte(2) // Field index 2, guestsNumber
      ..write(obj.guestsNumber)
      ..writeByte(3) // Field index 3, startsAt
      ..write(obj.startsAt.toIso8601String())
      ..writeByte(4) // Field index 4, endsAt
      ..write(obj.endsAt.toIso8601String())
      ..writeByte(5) // Field index 5, description
      ..write(obj.description)
      ..writeByte(6) // Field index 6, type
      ..write(obj.type)
      ..writeByte(7) // Field index 7, postType
      ..write(obj.postType)
      ..writeByte(8) // Field index 8, title
      ..write(obj.title)
      ..writeByte(9) // Field index 9, startingDate
      ..write(obj.startingDate.toIso8601String())
      ..writeByte(10) // Field index 10, endingDate
      ..write(obj.endingDate.toIso8601String())
      ..writeByte(11) // Field index 11, adultsOnly
      ..write(obj.adultsOnly)
      ..writeByte(12) // Field index 12, food
      ..write(obj.food)
      ..writeByte(13) // Field index 13, alcohol
      ..write(obj.alcohol)
      ..writeByte(14) // Field index 14, dressCode
      ..write(obj.dressCode)
      ..writeByte(15) // Field index 15, guests
      ..write(obj.guests);
  }
}
