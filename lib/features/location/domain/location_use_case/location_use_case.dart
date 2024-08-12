import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/location/data/models/location_model.dart';
import 'package:rick_and_morty/features/location/domain/location_repository/location_repository.dart';

/// EN: [LocationUseCase] - CharUseCase for location
///
/// RU: [LocationUseCase] - Юзкейс для работы location

class LocationUseCase {
  final LocationRepository locationRepositories;

  LocationUseCase({required this.locationRepositories});

  Future<LocationModel> getAllLocations() async {
    return await locationRepositories.getAllLocations();
  }

  Future<LocationResult> getLocationsById({required int id}) async {
    return await locationRepositories.getLocationsById(id: id);
  }
  Future<List<CharacterResult>> getResident(LocationResult result) async {
    return await locationRepositories.getResidents(result);
  }
}
