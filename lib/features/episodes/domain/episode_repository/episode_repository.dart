import 'package:rick_and_morty/features/episodes/data/models/episode_models.dart';

abstract class EpisodeRepository {
  /// EN: [getAllEpisodes] - getting all episodes
  ///
  /// RU: [getAllEpisodes] - получение всех episode
  Future<EpisodeModel> getAllEpisodes();

  /// EN: [getEpisodesById] - getting user by Id
  ///
  /// RU: [getEpisodesById] - получение episode по ID
  Future<EpisodeResult> getEpisodesById({required int id});
}
