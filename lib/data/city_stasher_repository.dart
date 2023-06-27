import 'package:city_stasher_lite/data/platform/location_service.dart';
import 'package:city_stasher_lite/data/remote/model/get_stashpoint_response.dart';
import 'package:city_stasher_lite/data/remote/stasher_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@singleton
class CityStasherRepository {
  final StasherService service;
  final LocationService locationService;

  CityStasherRepository(this.service, this.locationService);

  Future<List<Location>> getLocation(String address) {
    return locationService.getLocation(address);
  }

  Future<Position> getCurrentLocation() {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<GetStashPointResponse> getStashpoints({
    required bool active,
    required String availability,
    required int capacity,
    required String dropOff,
    required String pickUp,
    required double latitude,
    required double longtitude,
    required int page,
    required int itemCount,
    required String sort,
  }) {
    return service.getStashpoints(
      active,
      availability,
      capacity,
      dropOff,
      pickUp,
      latitude,
      longtitude,
      page,
      itemCount,
      sort,
    );
  }
}
