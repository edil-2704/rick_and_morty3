part of 'episodes_bloc.dart';

@immutable
sealed class EpisodesEvent {}

class GetAllEpisodes extends EpisodesEvent {
  final int page;
  final bool isFirstCall;

  GetAllEpisodes({
    required this.page,
    this.isFirstCall = false,
  });
}

class GetEpisodesById extends EpisodesEvent {
  final int id;

  GetEpisodesById({required this.id});
}
