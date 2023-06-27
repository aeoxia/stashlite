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

class SetDates extends StashpointListEvent {
  final DateTime dropOff;
  final DateTime pickUp;

  const SetDates({required this.dropOff, required this.pickUp});
}
