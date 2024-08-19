import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/domain/char_repository/char_repository.dart';

/// EN: [CharUseCase] - CharUseCase for users
///
/// RU: [CharUseCase] - Юзкейс для работы пользователей

class CharUseCase {
  final CharRepository charRepository;

  CharUseCase({required this.charRepository});
  

  Future<CharacterModel> getAllCharacters(int page) async {
    return await charRepository.getAllCharacters(page);
  }

  Future<CharacterResult> getCharactersById({required int id}) async {
    return await charRepository.getCharactersById(id: id);
  }
}