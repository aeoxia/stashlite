abstract class StashpointListEvent {
  const StashpointListEvent();
}

class GetStashpointList extends StashpointListEvent {
  final int page;
  const GetStashpointList({
    required this.page,
  });
}
