import 'package:hive/hive.dart';

import '../../../../invitaions/data/models/participant_model.dart';
import '../../../domain/entities/draft/draft.dart';

part 'draft_dto.g.dart';

@HiveType(typeId: 0)
class DraftDto extends HiveObject {
  DraftDto({
     this.id,
     this.title,
    this.description ,
    this.type,
    this.postType,
    this.startsAt,
    this.endsAt,
    this.startingDate,
    this.endingDate,
    this.dressCode,
    this.guestsNumber,
    this.guestsNumbers,
    this.adultsOnly,
    this.food,
    this.alcohol,
  });

  factory DraftDto.fromDraft(Draft draft) {
    return DraftDto(
      id: draft.id,
      title: draft.title,
      description: draft.description,
      type: draft.type,
      postType: draft.postType,
      startsAt: draft.startsAt,
      endsAt: draft.endsAt,
      startingDate: draft.startingDate,
      endingDate: draft.endingDate,
      dressCode: draft.dressCode,
      guestsNumber: draft.guestsNumber,
      guestsNumbers: draft.guestsNumbers,
      adultsOnly: draft.adultsOnly,
      food: draft.food,
      alcohol: draft.alcohol,
    );
  }

  @HiveField(0)
  String? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? type;

  @HiveField(4)
  String? postType;

  @HiveField(5)
  String? startsAt;

  @HiveField(6)
  String? endsAt;

  @HiveField(7)
  String? startingDate;

  @HiveField(8)
  String? endingDate;

  @HiveField(9)
  String? dressCode;

  @HiveField(10)
  int? guestsNumber;

  @HiveField(11)
  List<ParticipantModel>? guestsNumbers;

  @HiveField(12)
  bool? adultsOnly;

  @HiveField(13)
  bool? food;

  @HiveField(14)
  bool? alcohol;
}
