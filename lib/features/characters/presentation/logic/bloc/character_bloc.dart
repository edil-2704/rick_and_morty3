import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/domain/char_use_case/char_use_case.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final CharUseCase charUseCase;

  CharacterBloc({required this.charUseCase}) : super(CharacterInitialState()) {
    on<GetAllCharacters>((event, emit) async {
      emit(CharacterLoadingState());
      try {
        final CharacterModel result =
            await charUseCase.getAllCharacters();
        emit(CharacterLoadedState(characterModel:result));
      } catch (e) {
        emit(CharacterErrorState(error: CatchException.convertException(e)));
      }
    });

    on<GetCharactersById>((event, emit) async {
      emit(CharacterLoadingState());

      try {
        final CharacterResult result =
            await charUseCase.getCharactersById(id: event.id);

        emit(CharacterLoadedInfoState(result: result));
      } catch (e) {
        emit(CharacterErrorState(error: CatchException.convertException(e)));
      }
    });
    // on<CharacterEvent>((event, emit) {});
  }
}
