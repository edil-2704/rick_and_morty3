import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';

abstract class CharRepository {
  /// EN: [getAllCharacters] - getting all characters
  ///
  /// RU: [getAllCharacters] - получение всех персонажей
  Future<CharacterModel> getAllCharacters();

  /// EN: [getUserById] - getting user by Id
  ///
  /// RU: [getUserById] - получение пользователя по ID
  Future<CharacterResult> getCharactersById({required int id});
}
