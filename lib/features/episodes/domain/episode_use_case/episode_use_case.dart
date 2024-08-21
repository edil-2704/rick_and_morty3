import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/episodes/data/models/episode_models.dart';
import 'package:rick_and_morty/features/episodes/domain/episode_repository/episode_repository.dart';

/// EN: [EpisodeUseCase] - CharUseCase for episodes
///
/// RU: [EpisodeUseCase] - Юзкейс для работы episodes

@injectable
class EpisodeUseCase {
  final EpisodeRepository episodeRepository;

  EpisodeUseCase({required this.episodeRepository});
  

  Future<EpisodeModel> getAllEpisodes() async {
    return await episodeRepository.getAllEpisodes();
  }

  Future<EpisodeResult> getEpisodesById({required int id}) async {
    return await episodeRepository.getEpisodesById(id: id);
  }
}