import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/domain/char_use_case/char_use_case.dart';
import 'package:rick_and_morty/features/episodes/data/models/episode_models.dart';
import 'package:rick_and_morty/features/episodes/domain/episode_use_case/episode_use_case.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

part 'character_event.dart';

part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharUseCase charUseCase;
  final EpisodeUseCase? episodeUseCase;

  CharacterBloc({
    required this.charUseCase,
    this.episodeUseCase,
  }) : super(CharacterInitialState()) {
    on<GetAllCharactersEvent>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final CharacterModel result = await charUseCase.getAllCharacters();
        emit(CharacterLoadedState(characterModel: result));
      } catch (e) {
        emit(CharacterErrorState(error: CatchException.convertException(e)));
      }
    });

    on<GetCharactersByIdEvent>((event, emit) async {
      emit(CharacterLoadingState());

      try {
        final CharacterResult result =
            await charUseCase.getCharactersById(id: event.id);
        List<EpisodeResult> episodes = [];

        for (int i = 0; i <= result.episode!.length -1; i++) {
          List test = result.episode![i].split('/');

          String test2 = test.last;

          final EpisodeResult episodeResult =
              await episodeUseCase!.getEpisodesById(
            id: int.parse(test2),
          );
          episodes.add(episodeResult);
        }

        emit(CharacterLoadedInfoState(
          result: result,
          episodeResult: episodes,
        ));
      } catch (e) {
        emit(CharacterErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
