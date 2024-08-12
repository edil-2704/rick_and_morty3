part of 'location_bloc.dart';

@immutable
sealed class LocationState {}

final class LocationInitialState extends LocationState {}

final class LocationLoadingState extends LocationState {}

final class LocationLoadedState extends LocationState {
  final LocationModel locationModel;

  LocationLoadedState({required this.locationModel});
}

final class LocationErrorState extends LocationState {
  final CatchException error;

  LocationErrorState({required this.error});
}

final class LocationInfoLoadedState extends LocationState {
  final LocationResult locationResult;

  LocationInfoLoadedState({required this.locationResult});
}

class ResidentLoadedState extends LocationState {
  final List<CharacterResult> residentsModel;

  ResidentLoadedState({required this.residentsModel});
}
