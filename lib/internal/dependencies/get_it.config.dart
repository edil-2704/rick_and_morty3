// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/characters/data/repository/char_repository_impl.dart'
    as _i280;
import '../../features/characters/domain/char_repository/char_repository.dart'
    as _i446;
import '../../features/characters/domain/char_use_case/char_use_case.dart'
    as _i934;
import '../../features/characters/presentation/logic/bloc/character_bloc.dart'
    as _i232;
import '../../features/episodes/data/repository/episode_repository.dart'
    as _i793;
import '../../features/episodes/domain/episode_repository/episode_repository.dart'
    as _i581;
import '../../features/episodes/domain/episode_use_case/episode_use_case.dart'
    as _i633;
import '../../features/episodes/presentation/logic/bloc/episodes_bloc.dart'
    as _i294;
import '../../features/location/data/repository/location_repository_impl.dart'
    as _i206;
import '../../features/location/domain/location_repository/location_repository.dart'
    as _i80;
import '../../features/location/domain/location_use_case/location_use_case.dart'
    as _i30;
import '../../features/location/presentation/logic/bloc/location_bloc.dart'
    as _i626;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i446.CharRepository>(() => _i280.CharRepositoryImpl());
  gh.factory<_i581.EpisodeRepository>(() => _i793.EpisodeRepositoryImpl());
  gh.factory<_i934.CharUseCase>(
      () => _i934.CharUseCase(charRepository: gh<_i446.CharRepository>()));
  gh.factory<_i80.LocationRepository>(() => _i206.LocationRepositoryImpl());
  gh.factory<_i232.CharacterBloc>(() => _i232.CharacterBloc(
        charUseCase: gh<_i934.CharUseCase>(),
        episodeUseCase: gh<_i633.EpisodeUseCase>(),
      ));
  gh.factory<_i30.LocationUseCase>(() => _i30.LocationUseCase(
      locationRepositories: gh<_i80.LocationRepository>()));
  gh.factory<_i633.EpisodeUseCase>(() =>
      _i633.EpisodeUseCase(episodeRepository: gh<_i581.EpisodeRepository>()));
  gh.factory<_i626.LocationBloc>(() => _i626.LocationBloc(
        locationUseCase: gh<_i30.LocationUseCase>(),
        charUseCase: gh<_i934.CharUseCase>(),
      ));
  gh.factory<_i294.EpisodesBloc>(() => _i294.EpisodesBloc(
        episodeUseCase: gh<_i633.EpisodeUseCase>(),
        charUseCase: gh<_i934.CharUseCase>(),
      ));
  return getIt;
}
