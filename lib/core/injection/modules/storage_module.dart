import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../features/draft/data/dtos/draft/draft_dto.dart';

@module
abstract class StorageModule {
  @preResolve
  @lazySingleton
  Future<Box<DraftDto>> get draftBox {
    return Hive.openBox<DraftDto>('draftBox');
  }
}
