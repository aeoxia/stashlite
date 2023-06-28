abstract class StashpointListEvent {
  const StashpointListEvent();
}

class GetStashpointList extends StashpointListEvent {
  final int page;
  const GetStashpointList({
    required this.page,
  });
}

class IncreaseCapacity extends StashpointListEvent {
  const IncreaseCapacity();
}

class DecreaseCapacity extends StashpointListEvent {
  const DecreaseCapacity();
}

class SortStashpointList extends StashpointListEvent {
  final int index;
  const SortStashpointList({required this.index});
}

class SetDates extends StashpointListEvent {
  final DateTime dropOff;
  final DateTime pickUp;

  const SetDates({required this.dropOff, required this.pickUp});
}

class GetSuggestions extends StashpointListEvent {
  final String address;

  GetSuggestions(this.address);
}

class SelectLocation extends StashpointListEvent {
  final String name;
  final double latitude;
  final double longitude;

  SelectLocation(this.name, this.latitude, this.longitude);
}

class GetCurrentLocation extends StashpointListEvent {
  const GetCurrentLocation();
}
