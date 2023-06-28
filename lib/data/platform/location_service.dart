import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
class LocationService {
  Future<Position> getCurrentLocation() {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<LocationItem>> getLocations(String address) {
    return locationFromAddress(address).then((value) => Future.wait(
          value.map(
            (location) {
              return placemarkFromCoordinates(
                      location.latitude, location.longitude)
                  .then(
                (placemarkList) => placemarkList.map(
                  (placemark) {
                    return LocationItem(
                        [
                          placemark.name,
                          placemark.subThoroughfare,
                          placemark.thoroughfare,
                          placemark.street,
                          placemark.subLocality,
                          placemark.locality,
                          placemark.postalCode,
                          placemark.subAdministrativeArea,
                          placemark.administrativeArea
                        ].assemble(),
                        location.latitude,
                        location.longitude);
                  },
                ).toList(),
              );
            },
          ),
        ).then((value) => value.expand((element) => element).toList()));
  }
}

extension LocationFormatter on List<String?> {
  String assemble() {
    return map((e) => (e ?? "").trim()).join(" ");
  }
}
