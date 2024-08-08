import 'package:rick_and_morty/features/location/data/models/location_model.dart';

abstract class LocationRepository {
  /// EN: [getAllLocations] - getting all characters
  ///
  /// RU: [getAllLocations] - получение всех персонажей
  Future<LocationModel> getAllLocations();

  /// EN: [getLocationsById] - getting locations by Id
  ///
  /// RU: [getLocationsById] - получение locations по ID
  Future<LocationResult> getLocationsById({required int id});
}
