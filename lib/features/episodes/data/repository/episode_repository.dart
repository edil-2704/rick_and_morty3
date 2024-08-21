import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/episodes/data/models/episode_models.dart';
import 'package:rick_and_morty/features/episodes/domain/episode_repository/episode_repository.dart';
import 'package:rick_and_morty/internal/helpers/api_requester/api_requester.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

@Injectable(as: EpisodeRepository)
class EpisodeRepositoryImpl implements EpisodeRepository {
  final ApiRequester apiRequester = ApiRequester();

  @override
  Future<EpisodeModel> getAllEpisodes() async {
    try {
      Response response = await apiRequester.toGet('episode');

      print('getAllEpisodes = ${response.statusCode}');
      print('getAllEpisodes = ${response.data}');

      if (response.statusCode == 200) {
        return EpisodeModel.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      print(e);
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<EpisodeResult> getEpisodesById({required int id}) async {

    try {
      Response response = await apiRequester.toGet('episode/$id');

      print('getCharactersById = ${response.statusCode}');
      print('getCharactersById = ${response.data}');

      print(response.data);
      if (response.statusCode == 200) {
        return EpisodeResult.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      print('getCharactersById = $e');

      throw CatchException.convertException(e);
    }
  }
}
