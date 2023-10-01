import 'package:injectable/injectable.dart';

import '../../domain/entities/draft/draft.dart';
import '../dtos/draft/draft_dto.dart';
import '../local_sources/draft_local_source.dart';
import 'draft_repository.dart';

@Injectable(as: DraftRepository)
class DraftRepositoryImp implements DraftRepository {
  const DraftRepositoryImp(this._draftLocalSource);

  final DraftLocalSource _draftLocalSource;

  @override
  Future<void> add(Draft draft) async {
    final draftDto = DraftDto.fromDraft(draft);
    await _draftLocalSource.add(draftDto);
  }

  @override
  Future<void> update(Draft draft) {
    final draftDto = DraftDto.fromDraft(draft);
    return _draftLocalSource.update(draftDto);
  }

  @override
  List<Draft> loadAllDraft() {
    final draftDtos = _draftLocalSource.loadAllDraftDto();
    return draftDtos.map(Draft.fromDraftDto).toList();
  }

  @override
  Stream<List<Draft>> watchAllDraft() {
    return _draftLocalSource.watchDraftDto().map((draftDtoList) {
      return draftDtoList.map(Draft.fromDraftDto).toList();
    });
  }

  @override
  Future<void> delete(String id) {
    return _draftLocalSource.delete(id);
  }

  @override
  Future<void> deleteAll() {
    return _draftLocalSource.deleteAll();
  }
}
