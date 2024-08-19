import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/domain/char_use_case/char_use_case.dart';
import 'package:rick_and_morty/features/episodes/data/models/episode_models.dart';
import 'package:rick_and_morty/features/episodes/domain/episode_use_case/episode_use_case.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

part 'episodes_event.dart';

part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final EpisodeUseCase episodeUseCase;
  final CharUseCase? charUseCase;

  EpisodesBloc({required this.episodeUseCase, this.charUseCase})
      : super(EpisodesInitialState()) {
    on<GetAllEpisodes>((event, emit) async {
      if (event.isFirstCall) {
        emit(EpisodesLoadingState());
      }

      try {
        final EpisodeModel result = await episodeUseCase.getAllEpisodes();

        emit(EpisodesLoadedState(episodeModel: result));
      } catch (e) {
        emit(EpisodesErrorState(error: CatchException.convertException(e)));
      }
    });
    on<GetEpisodesById>((event, emit) async {
      emit(EpisodesLoadingState());

      try {
        final EpisodeResult result =
            await episodeUseCase.getEpisodesById(id: event.id);

        List<CharacterResult> characters = [];

        for (int i = 0; i <= result.characters!.length - 1; i++) {
          List test = result.characters![i].split('/');

          String test2 = test.last;
          log('test2 value: $test2');
          log('Processing ID: $test2');
          // if (RegExp(r'^\d+$').hasMatch(test2)) {
          //   try {
          //     final int characterId = int.parse(test2);
          //     final CharacterResult characterResult =
          //     await charUseCase!.getCharactersById(id: characterId);
          //     episodes.add(characterResult);
          //   } catch (e) {
          //     log('Failed to parse character ID: $test2, error: $e');
          //     continue; // Пропуск итерации, если произошла ошибка
          //   }
          // } else {
          //   log('Invalid ID format: $test2');
          //   continue; // Пропуск итерации, если формат ID неверен
          // }

          final CharacterResult characterResult =
              await charUseCase!.getCharactersById(id: int.parse(test2));
          characters.add(characterResult);
        }

        emit(EpisodesLoadedInfoState(
          result: result,
          characterResult: characters,
        ));
      } catch (e) {
        log('error is $e');
        emit(EpisodesErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
