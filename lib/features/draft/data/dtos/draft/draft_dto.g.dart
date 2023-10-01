// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'draft_dto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DraftDtoAdapter extends TypeAdapter<DraftDto> {
  @override
  final int typeId = 0;

  @override
  DraftDto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DraftDto(
      id: fields[0] as String?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      type: fields[3] as String?,
      postType: fields[4] as String?,
      startsAt: fields[5] as String?,
      endsAt: fields[6] as String?,
      startingDate: fields[7] as String?,
      endingDate: fields[8] as String?,
      dressCode: fields[9] as String?,
      guestsNumber: fields[10] as int?,
      guestsNumbers: (fields[11] as List?)?.cast<ParticipantModel>(),
      adultsOnly: fields[12] as bool?,
      food: fields[13] as bool?,
      alcohol: fields[14] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, DraftDto obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.postType)
      ..writeByte(5)
      ..write(obj.startsAt)
      ..writeByte(6)
      ..write(obj.endsAt)
      ..writeByte(7)
      ..write(obj.startingDate)
      ..writeByte(8)
      ..write(obj.endingDate)
      ..writeByte(9)
      ..write(obj.dressCode)
      ..writeByte(10)
      ..write(obj.guestsNumber)
      ..writeByte(11)
      ..write(obj.guestsNumbers)
      ..writeByte(12)
      ..write(obj.adultsOnly)
      ..writeByte(13)
      ..write(obj.food)
      ..writeByte(14)
      ..write(obj.alcohol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DraftDtoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
