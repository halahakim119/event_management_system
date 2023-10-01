import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../dtos/draft/draft_dto.dart';

abstract class DraftLocalSource {
  Future<void> add(DraftDto draftDto);
  Future<void> update(DraftDto draftDto);
  Future<void> delete(String id);
  Future<void> deleteAll();
  List<DraftDto> loadAllDraftDto();
  Stream<List<DraftDto>> watchDraftDto();
}

@Injectable(as: DraftLocalSource)
class DraftLocalSourceImpl implements DraftLocalSource {
  const DraftLocalSourceImpl(this._draftBox);

  final Box<DraftDto> _draftBox;

  @override
  Future<void> add(DraftDto draftDto) async {
    await _draftBox.put(draftDto.id, draftDto);
  }

  @override
  Future<void> update(DraftDto draftDto) async {
    await _draftBox.delete(draftDto.id);
    draftDto.id = DateTime.now().toString();
    await _draftBox.put(draftDto.id, draftDto);
  }

  @override
  Future<void> delete(String id) async {
    await _draftBox.delete(id);
  }

  @override
  List<DraftDto> loadAllDraftDto() {
    return _draftBox.values.toList();
  }

  @override
  Future<void> deleteAll() async {
    await _draftBox.clear();
  }

  @override
  Stream<List<DraftDto>> watchDraftDto() {
    return _draftBox.watch().map((_) => _draftBox.values.toList());
  }
}
