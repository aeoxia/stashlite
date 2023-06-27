// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'data/city_stasher_repository.dart' as _i6;
import 'data/data_module.dart' as _i8;
import 'data/platform/location_service.dart' as _i4;
import 'data/remote/stasher_service.dart' as _i5;
import 'presentation/stashpoint_list/stashpoint_list_bloc.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final dataModule = _$DataModule();
    gh.factory<_i3.Dio>(() => dataModule.dio);
    gh.factory<_i4.LocationService>(() => _i4.LocationService());
    gh.factory<_i5.StasherService>(
        () => dataModule.getStasherService(gh<_i3.Dio>()));
    gh.singleton<_i6.CityStasherRepository>(_i6.CityStasherRepository(
      gh<_i5.StasherService>(),
      gh<_i4.LocationService>(),
    ));
    gh.factory<_i7.StashpointListBloc>(
        () => _i7.StashpointListBloc(gh<_i6.CityStasherRepository>()));
    return this;
  }
}

class _$DataModule extends _i8.DataModule {}
