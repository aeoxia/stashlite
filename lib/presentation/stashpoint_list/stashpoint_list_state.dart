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
    @Default("") String longtitude,
    @Default("") String latitude,
    @Default("") String sort,
    @Default("") String currentLocationName,
    @Default(0) int selectedSort,
    @Default(0) int currentPage,
    @Default(false) bool isLastPage,
  }) = _StashpointListState;
}

class StashpointItem {
  final String id;
  final String name;

  StashpointItem(this.id, this.name);
}

Map<int, String> sortFilter = {0: "distance", 1: "rating"};
