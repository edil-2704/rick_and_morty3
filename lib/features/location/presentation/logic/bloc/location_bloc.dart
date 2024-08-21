import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/characters/domain/char_use_case/char_use_case.dart';
import 'package:rick_and_morty/features/location/data/models/location_model.dart';
import 'package:rick_and_morty/features/location/domain/location_use_case/location_use_case.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

part 'location_event.dart';

part 'location_state.dart';

@injectable
class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationUseCase locationUseCase;
  final CharUseCase charUseCase;

  LocationBloc({
    required this.locationUseCase,
    required this.charUseCase,
  }) : super(LocationInitialState()) {
    on<GetAllLocations>((event, emit) async {

      if (event.isFirstCall) {
        emit(LocationLoadingState());
      }

      try {
        final LocationModel result = await locationUseCase.getAllLocations();

        emit(LocationLoadedState(locationModel: result));
      } catch (e) {
        emit(LocationErrorState(error: CatchException.convertException(e)));
      }
    });

    on<GetLocationsById>((event, emit) async {
      emit(LocationLoadingState());

      try {
        final LocationResult result =
            await locationUseCase.getLocationsById(id: event.id);

        List<CharacterResult> characters = [];

        for (int i = 0; i <= result.residents!.length - 1; i++) {
          List test = result.residents![i].split('/');

          String test2 = test.last;

          log('test2 value: $test2');
          log('Processing ID: $test2');

          final CharacterResult characterResult =
              await charUseCase.getCharactersById(id: int.parse(test2));

          characters.add(characterResult);
        }

        emit(LocationInfoLoadedState(
          residentsModel: characters,
          locationResult: result,
        ));
      } catch (e) {
        emit(LocationErrorState(error: CatchException.convertException(e)));
      }
    });
  }
}
