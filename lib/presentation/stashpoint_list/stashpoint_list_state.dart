import 'package:freezed_annotation/freezed_annotation.dart';
part 'stashpoint_list_state.freezed.dart';

@freezed
class StashpointListState with _$StashpointListState {
  const factory StashpointListState({
    @Default(true) bool isLoading,
    @Default([]) List<StashpointItem> stashpointList,
    @Default(1) int capacity,
    @Default("") String dropOff,
    @Default("") String pickUp,
    @Default("distance") String sort,
    @Default(0) int selectedSort,
    @Default(0) int currentPage,
    @Default(false) bool isLastPage,
    @Default(null) LocationItem? selectedLocation,
  }) = _StashpointListState;
}

class StashpointItem {
  final String id;
  final String name;
  final String image;
  final String address;
  final String rating;
  final bool isAlwaysOpen;
  final String price;

  StashpointItem(
      {required this.id,
      required this.name,
      required this.image,
      required this.address,
      required this.rating,
      required this.isAlwaysOpen,
      required this.price});
}

Map<int, String> sortFilter = {0: "distance", 1: "rating"};

class LocationItem {
  final String name;
  final double latitude;
  final double longitude;

  LocationItem(this.name, this.latitude, this.longitude);
}
