import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/episodes/data/models/episode_models.dart';
import 'package:rick_and_morty/features/episodes/domain/episode_use_case/episode_use_case.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

part 'episodes_event.dart';
part 'episodes_state.dart';

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final EpisodeUseCase episodeUseCase;

  EpisodesBloc({required this.episodeUseCase}) : super(EpisodesInitialState()) {
    on<GetAllEpisodes>((event, emit) async {
      emit(EpisodesLoadingState());

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

        emit(EpisodesLoadedInfoState(result: result));
      } catch (e) {
        emit(EpisodesErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
