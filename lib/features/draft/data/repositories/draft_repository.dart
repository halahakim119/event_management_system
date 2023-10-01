
import '../../domain/entities/draft/draft.dart';

abstract class DraftRepository {
  Future<void> add(Draft draft);
  Future<void> update(Draft draft);
    Future<void> delete(String id);
  Future<void> deleteAll();
  List<Draft> loadAllDraft();
  Stream<List<Draft>> watchAllDraft();
}
