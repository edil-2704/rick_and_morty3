import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/location/data/models/location_model.dart';
import 'package:rick_and_morty/features/location/domain/location_use_case/location_use_case.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

part 'location_event.dart';

part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationUseCase locationUseCase;

  LocationBloc({required this.locationUseCase})
      : super(LocationInitialState()) {
    on<GetAllLocations>((event, emit) async {
      emit(LocationLoadingState());

      try {
        final LocationModel result = await locationUseCase.getAllLocations();

        emit(LocationLoadedState(locationModel: result));
      } catch (e) {
        emit(LocationErrorState(error: CatchException.convertException(e)));
      }
    });

    on<GetLocationsById>((event, emit) async {
      try {
        final LocationResult result =
            await locationUseCase.getLocationsById(id: event.id);

        emit(LocationInfoLoadedState(locationResult: result));
      } catch (e) {
        log('error is $e');
        emit(LocationErrorState(error: CatchException.convertException(e)));
      }


    });
    on<GetResidentEvent>((event, emit) async {
      try {
        List<CharacterResult> charModelList =

        await locationUseCase.getResident(event.locationResult);

        emit(ResidentLoadedState(residentsModel: charModelList));
      } catch (e) {
        log('error is $e');
        emit(LocationErrorState(error: CatchException.convertException(e)));
      }


    });


  }
}
