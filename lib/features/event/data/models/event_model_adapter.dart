import 'package:hive/hive.dart';

import '../../../user/data/models/user_model.dart';
import '../models/event_model.dart';

class EventModelAdapter extends TypeAdapter<EventModel> {
  @override
  final int typeId = 2; // Assign a unique ID for the adapter

  @override
  EventModel read(BinaryReader reader) {
    final fieldsCount = reader.readByte();
    final fields = <int, dynamic>{};
    for (var i = 0; i < fieldsCount; i++) {
      final key = reader.readByte();
      final dynamic value = reader.read();
      fields[key] = value;
    }

    return EventModel(
      id: fields[0] as String?,
      hostId: fields[1] as String,
      plannerId: fields[2] as String,
      title: fields[3] as String,
      description: fields[4] as String,
      guestsNumber: fields[5] as int,
      type: fields[6] as String,
      postType: fields[7] as String,
      startsAt: DateTime.parse(fields[8] as String),
      endsAt: DateTime.parse(fields[9] as String),
      startingDate: DateTime.parse(fields[10] as String),
      endingDate: DateTime.parse(fields[11] as String),
      adultsOnly: fields[12] as bool,
      food: fields[13] as bool,
      alcohol: fields[14] as bool,
      dressCode: fields[15] as String?,
      guests: (fields[16] as List<dynamic>)
          .map((guestJson) => UserModel.fromJson(guestJson))
          .toList(),
      confirmedGuests: (fields[17] as List<dynamic>)
          .map((confirmedGuestJson) => UserModel.fromJson(confirmedGuestJson))
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(18) // Number of fields in the EventModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, hostId
      ..write(obj.hostId)
      ..writeByte(2) // Field index 2, plannerId
      ..write(obj.plannerId)
      ..writeByte(3) // Field index 3, title
      ..write(obj.title)
      ..writeByte(4) // Field index 4, description
      ..write(obj.description)
      ..writeByte(5) // Field index 5, guestsNumber
      ..write(obj.guestsNumber)
      ..writeByte(6) // Field index 6, type
      ..write(obj.type)
      ..writeByte(7) // Field index 7, postType
      ..write(obj.postType)
      ..writeByte(8) // Field index 8, startsAt
      ..write(obj.startsAt.toIso8601String())
      ..writeByte(9) // Field index 9, endsAt
      ..write(obj.endsAt.toIso8601String())
      ..writeByte(10) // Field index 10, startingDate
      ..write(obj.startingDate.toIso8601String())
      ..writeByte(11) // Field index 11, endingDate
      ..write(obj.endingDate.toIso8601String())
      ..writeByte(12) // Field index 12, adultsOnly
      ..write(obj.adultsOnly)
      ..writeByte(13) // Field index 13, food
      ..write(obj.food)
      ..writeByte(14) // Field index 14, alcohol
      ..write(obj.alcohol)
      ..writeByte(15) // Field index 15, dressCode
      ..write(obj.dressCode)
      ..writeByte(16) // Field index 16, guests
      ..write(obj.guests
          ?.map((guest) => UserModel.fromEntity(guest).toJson())
          .toList())
      ..writeByte(17) // Field index 17, confirmedGuests
      ..write(obj.confirmedGuests
          ?.map(
              (confirmedGuest) => UserModel.fromEntity(confirmedGuest).toJson())
          .toList());
  }
}
