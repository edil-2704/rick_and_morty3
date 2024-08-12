part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class GetAllLocations extends LocationEvent {}

class GetLocationsById extends LocationEvent {
  final int id;

  GetLocationsById({required this.id});
}

class GetResidentEvent extends LocationEvent {
  final LocationResult locationResult;

  GetResidentEvent({required this.locationResult});
}