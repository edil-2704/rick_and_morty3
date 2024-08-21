import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/domain/char_repository/char_repository.dart';
import 'package:rick_and_morty/internal/helpers/api_requester/api_requester.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

@Injectable(as: CharRepository)
class CharRepositoryImpl implements CharRepository {
  final ApiRequester apiRequester = ApiRequester();

  @override
  Future<CharacterModel> getAllCharacters(int page) async {
    try {
      Response response = await apiRequester.toGet(
        'character',
        params: {'page': page},
      );

      print('getAllCharacters = ${response.statusCode}');
      print('getAllCharacters = ${response.data}');

      if (response.statusCode == 200) {
        return CharacterModel.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      print(e);
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<CharacterResult> getCharactersById({required int id}) async {
    try {
      Response response = await apiRequester.toGet('character/$id');

      print('getCharactersById = ${response.statusCode}');
      print('getCharactersById = ${response.data}');

      print(response.data);
      if (response.statusCode == 200) {
        return CharacterResult.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      print('getCharactersById = $e');

      throw CatchException.convertException(e);
    }
  }
}
