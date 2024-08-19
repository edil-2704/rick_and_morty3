part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class GetAllLocations extends LocationEvent {
  final int page;
  final bool isFirstCall;

  GetAllLocations({
    required this.page,
    this.isFirstCall = false,
  });
}

class GetLocationsById extends LocationEvent {
  final int id;

  GetLocationsById({required this.id});
}

