part of 'episodes_bloc.dart';

@immutable
sealed class EpisodesState {}

final class EpisodesInitialState extends EpisodesState {}

final class EpisodesLoadingState extends EpisodesState {}

final class EpisodesLoadedState extends EpisodesState {
  final EpisodeModel episodeModel;

  EpisodesLoadedState({required this.episodeModel});
}

final class EpisodesErrorState extends EpisodesState {
  final CatchException error;

  EpisodesErrorState({required this.error});
}

final class EpisodesLoadedInfoState extends EpisodesState {
  final EpisodeResult result;

  EpisodesLoadedInfoState({required this.result});
}
