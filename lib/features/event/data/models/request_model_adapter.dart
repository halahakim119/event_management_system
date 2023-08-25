import 'package:hive/hive.dart';

import '../models/request_model.dart';

class RequestModelAdapter extends TypeAdapter<RequestModel> {
  @override
  final int typeId = 4; // Assign a unique ID for the adapter

  @override
  RequestModel read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return RequestModel(
      id: fields[0] as String,
      plannerId: fields[1] as String,
      hostId: fields[2] as String,
      hostName: fields[3] as String,
      guestsNumber: fields[4] as int,
      startsAt: DateTime.parse(fields[5] as String),
      endsAt: DateTime.parse(fields[6] as String),
      description: fields[7] as String,
      type: fields[8] as String,
      postType: fields[9] as String,
      title: fields[10] as String,
      startingDate: DateTime.parse(fields[11] as String),
      endingDate: DateTime.parse(fields[12] as String),
      adultsOnly: fields[13] as bool,
      food: fields[14] as bool,
      alcohol: fields[15] as bool,
      dressCode: fields[16] as String?,
      guests: (fields[17] as List<dynamic>).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, RequestModel obj) {
    writer
      ..writeByte(18) // Number of fields in the RequestModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, plannerId
      ..write(obj.plannerId)
      ..writeByte(2) // Field index 2, hostId
      ..write(obj.hostId)
      ..writeByte(3) // Field index 3, hostName
      ..write(obj.hostName)
      ..writeByte(4) // Field index 4, guestsNumber
      ..write(obj.guestsNumber)
      ..writeByte(5) // Field index 5, startsAt
      ..write(obj.startsAt.toIso8601String())
      ..writeByte(6) // Field index 6, endsAt
      ..write(obj.endsAt.toIso8601String())
      ..writeByte(7) // Field index 7, description
      ..write(obj.description)
      ..writeByte(8) // Field index 8, type
      ..write(obj.type)
      ..writeByte(9) // Field index 9, postType
      ..write(obj.postType)
      ..writeByte(10) // Field index 10, title
      ..write(obj.title)
      ..writeByte(11) // Field index 11, startingDate
      ..write(obj.startingDate.toIso8601String())
      ..writeByte(12) // Field index 12, endingDate
      ..write(obj.endingDate.toIso8601String())
      ..writeByte(13) // Field index 13, adultsOnly
      ..write(obj.adultsOnly)
      ..writeByte(14) // Field index 14, food
      ..write(obj.food)
      ..writeByte(15) // Field index 15, alcohol
      ..write(obj.alcohol)
      ..writeByte(16) // Field index 16, dressCode
      ..write(obj.dressCode)
      ..writeByte(17) // Field index 17, guests
      ..write(obj.guests);
  }
}
