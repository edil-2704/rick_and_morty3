import 'package:rick_and_morty/features/location/data/models/location_model.dart';
import 'package:rick_and_morty/features/location/domain/location_repository/location_repository.dart';

/// EN: [LocationUseCase] - CharUseCase for location
///
/// RU: [LocationUseCase] - Юзкейс для работы location

class LocationUseCase {
  final LocationRepository locationRepostory;

  LocationUseCase({required this.locationRepostory});

  Future<LocationModel> getAllLocations() async {
    return await locationRepostory.getAllLocations();
  }

  Future<LocationResult> getLocationsById({required int id}) async {
    return await locationRepostory.getLocationsById(id: id);
  }
}
