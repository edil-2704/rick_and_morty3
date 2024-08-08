part of 'episodes_bloc.dart';

@immutable
sealed class EpisodesEvent {}

class GetAllEpisodes extends EpisodesEvent {}

class GetEpisodesById extends EpisodesEvent {
  final int id;

  GetEpisodesById({required this.id});
}
