import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rick_and_morty/features/characters/data/models/characters_models.dart';
import 'package:rick_and_morty/features/location/data/models/location_model.dart';
import 'package:rick_and_morty/features/location/domain/location_repository/location_repository.dart';
import 'package:rick_and_morty/internal/helpers/api_requester/api_requester.dart';
import 'package:rick_and_morty/internal/helpers/catch_exception/catch_exception.dart';

class LocationRepositoryImpl implements LocationRepository {
  final ApiRequester apiRequester = ApiRequester();

  @override
  Future<LocationModel> getAllLocations() async {
    try {
      Response response = await apiRequester.toGet('location');

      log('getAllLocations = ${response.statusCode}');
      log('getAllLocations = ${response.data}');

      if (response.statusCode == 200) {
        return LocationModel.fromJson(response.data);
      }
      throw response;
    } catch (e) {
      print(e);
      throw CatchException.convertException(e);
    }
  }

  @override
  Future<LocationResult> getLocationsById({required int id}) async {
    try {
      Response response = await apiRequester.toGet('location/$id');

      log('getLocationsById = ${response.statusCode}');
      log('getLocationsById = ${response.data}');


      if (response.statusCode == 200) {
        return LocationResult.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      log('err getLocationsById = $e');

      throw CatchException.convertException(e);
    }
  }

  @override
  Future<List<CharacterResult>> getResidents(LocationResult locationResidents) async {
    List<CharacterResult> residentModelList = [];
    try {
      for (var element in locationResidents.residents ?? []) {
        Response response = await apiRequester
            .toGet('api/character/${element.replaceAll(RegExp('[^0-9]'), "")}');

        residentModelList.add(CharacterResult.fromJson(response.data));
      }
      log("=" * 5);
      log(residentModelList.toString());
      return residentModelList;
    } catch (e) {
      print("error == $e");
      throw CatchException.convertException(e);
    }

  }
}
