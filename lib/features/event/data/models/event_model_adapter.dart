import 'package:hive/hive.dart';

import '../../../host/domain/entities/host_entity.dart';
import '../../../invitaions/data/models/participant_model.dart';
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
      plannerId: fields[1] as String,
      host: fields[2] as HostEntity?,
      title: fields[4] as String,
      description: fields[5] as String,
      guestsNumber: fields[6] as int,
      type: fields[7] as String,
      postType: fields[8] as String,
      startsAt: fields[9] as String,
      endsAt: fields[10] as String,
      startingDate: fields[11] as String,
      endingDate: fields[12] as String,
      adultsOnly: fields[13] as bool,
      food: fields[14] as bool,
      alcohol: fields[15] as bool,
      dressCode: fields[16] as String?,
      guestsNumbers: (fields[17] as List<dynamic>).cast<String>(),
      guests: (fields[18] as List<dynamic>)
          .map((guestJson) => ParticipantModel.fromJson(guestJson).toEntity())
          .toList(),
      confirmedGuests: (fields[19] as List<dynamic>)
          .map((confirmedGuestJson) =>
              ParticipantModel.fromJson(confirmedGuestJson).toEntity())
          .toList(),
    );
  }

  @override
  void write(BinaryWriter writer, EventModel obj) {
    writer
      ..writeByte(19) // Number of fields in the EventModel class
      ..writeByte(0) // Field index 0, id
      ..write(obj.id)
      ..writeByte(1) // Field index 1, plannerId
      ..write(obj.plannerId)
      ..writeByte(2) // Field index 2, hostId
      ..write(obj.host)
      ..writeByte(3) // Field index 4, title
      ..write(obj.title)
      ..writeByte(4) // Field index 5, description
      ..write(obj.description)
      ..writeByte(5) // Field index 6, guestsNumber
      ..write(obj.guestsNumber)
      ..writeByte(6) // Field index 7, type
      ..write(obj.type)
      ..writeByte(7) // Field index 8, postType
      ..write(obj.postType)
      ..writeByte(8) // Field index 9, startsAt
      ..write(obj.startsAt)
      ..writeByte(9) // Field index 10, endsAt
      ..write(obj.endsAt)
      ..writeByte(10) // Field index 11, startingDate
      ..write(obj.startingDate)
      ..writeByte(11) // Field index 12, endingDate
      ..write(obj.endingDate)
      ..writeByte(12) // Field index 13, adultsOnly
      ..write(obj.adultsOnly)
      ..writeByte(13) // Field index 14, food
      ..write(obj.food)
      ..writeByte(14) // Field index 15, alcohol
      ..write(obj.alcohol)
      ..writeByte(15) // Field index 16, dressCode
      ..write(obj.dressCode)
      ..writeByte(16) // Field index 17, guestsNumbers
      ..write(obj.guestsNumbers)
      ..writeByte(17) // Field index 18, guests
      ..write(obj.guests
          ?.map((guest) => ParticipantModel.fromEntity(guest).toJson())
          .toList())
      ..writeByte(18) // Field index 19, confirmedGuests
      ..write(obj.confirmedGuests
          ?.map((confirmedGuest) =>
              ParticipantModel.fromEntity(confirmedGuest).toJson())
          .toList());
  }
}
