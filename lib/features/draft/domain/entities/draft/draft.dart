import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../invitaions/data/models/participant_model.dart';
import '../../../data/dtos/draft/draft_dto.dart';

part 'draft.freezed.dart';

@freezed
class Draft with _$Draft {
  const factory Draft({
     String? id,
    String? title,
    String? description,
    String? type,
    String? postType,
    String? startsAt,
    String? endsAt,
    String? startingDate,
    String? endingDate,
    String? dressCode,
    int? guestsNumber,
    List<ParticipantModel>? guestsNumbers,
    bool? adultsOnly,
    bool? food,
    bool? alcohol,
  }) = _Draft;

  factory Draft.fromDraftDto(DraftDto draftDto) {
    return Draft(
      id: draftDto.id,
      title: draftDto.title,
      description: draftDto.description,
      type: draftDto.type,
      postType: draftDto.postType,
      startsAt: draftDto.startsAt,
      endsAt: draftDto.endsAt,
      startingDate: draftDto.startingDate,
      endingDate: draftDto.endingDate,
      dressCode: draftDto.dressCode,
      guestsNumber: draftDto.guestsNumber,
      guestsNumbers: draftDto.guestsNumbers,
      adultsOnly: draftDto.adultsOnly,
      food: draftDto.food,
      alcohol: draftDto.alcohol,
    );
  }
}
