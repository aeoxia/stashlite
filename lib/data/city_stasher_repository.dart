import 'package:city_stasher_lite/data/remote/model/get_stashpoint_response.dart';
import 'package:city_stasher_lite/data/remote/stasher_service.dart';
import 'package:injectable/injectable.dart';

@singleton
class CityStasherRepository {
  final StasherService service;

  CityStasherRepository(this.service);

  Future<GetStashPointResponse> getStashpoints({
    required bool active,
    required String availability,
    required int capacity,
    required String dropOff,
    required String pickUp,
    required String latitude,
    required String longtitude,
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
