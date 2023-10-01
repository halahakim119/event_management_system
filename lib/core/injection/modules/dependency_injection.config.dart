// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:event_management_system/core/injection/modules/storage_module.dart'
    as _i11;
import 'package:event_management_system/features/draft/application/draft_bloc/draft_bloc.dart'
    as _i9;
import 'package:event_management_system/features/draft/application/draft_list_bloc/draft_list_bloc.dart'
    as _i10;
import 'package:event_management_system/features/draft/data/dtos/draft/draft_dto.dart'
    as _i4;
import 'package:event_management_system/features/draft/data/local_sources/draft_local_source.dart'
    as _i5;
import 'package:event_management_system/features/draft/data/repositories/draft_repository.dart'
    as _i7;
import 'package:event_management_system/features/draft/data/repositories/draft_repository_imp.dart'
    as _i8;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i6;
import 'package:hive_flutter/hive_flutter.dart' as _i3;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final storageModule = _$StorageModule();
    await gh.lazySingletonAsync<_i3.Box<_i4.DraftDto>>(
      () => storageModule.draftBox,
      preResolve: true,
    );
    gh.factory<_i5.DraftLocalSource>(
        () => _i5.DraftLocalSourceImpl(gh<_i6.Box<_i4.DraftDto>>()));
    gh.factory<_i7.DraftRepository>(
        () => _i8.DraftRepositoryImp(gh<_i5.DraftLocalSource>()));
    gh.factory<_i9.DraftBloc>(() => _i9.DraftBloc(gh<_i7.DraftRepository>()));
    gh.factory<_i10.DraftListBloc>(
        () => _i10.DraftListBloc(gh<_i7.DraftRepository>()));
    return this;
  }
}

class _$StorageModule extends _i11.StorageModule {}
