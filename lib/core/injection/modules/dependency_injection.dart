import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../features/draft/data/dtos/draft/draft_dto.dart';
import '../../../features/invitaions/data/models/participant_model.dart';
import '../../../features/invitaions/data/models/participant_model_adapter.dart';
import 'dependency_injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  await Hive.initFlutter();
  await registerHiveTypeAdapters();
  await getIt.init();
}

Future<void> registerHiveTypeAdapters() async {
  Hive.registerAdapter(DraftDtoAdapter());
  Hive.registerAdapter<ParticipantModel>(ParticipantModelAdapter());
}
