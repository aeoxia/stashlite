import 'package:freezed_annotation/freezed_annotation.dart';
part 'stashpoint_list_state.freezed.dart';

@freezed
class StashpointListState with _$StashpointListState {
  const factory StashpointListState({
    @Default(true) bool isLoading,
    @Default([]) List<StashpointItem> stashpointList,
  }) = _StashpointListState;
}

class StashpointItem {
  final String id;
  final String name;

  StashpointItem(this.id, this.name);
}
