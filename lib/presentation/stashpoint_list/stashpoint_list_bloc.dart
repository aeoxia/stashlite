import 'dart:async';

import 'package:city_stasher_lite/data/city_stasher_repository.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_event.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_state.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@injectable
class StashpointListBloc
    extends Bloc<StashpointListEvent, StashpointListState> {
  final CityStasherRepository _repository;
  StashpointListBloc(this._repository) : super(const StashpointListState()) {
    on<GetStashpointList>(_getStashpointList);
  }

  FutureOr<void> _getStashpointList(
      GetStashpointList event, Emitter<StashpointListState> emit) async {
    if (state.stashpointList.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }
    final result = await _repository.getStashpoints(
      active: true,
      availability: "all",
      capacity: 1,
      dropOff: "2023-06-25T18:00:00",
      pickUp: "2023-06-25T19:00:00",
      latitude: "-0.0810913",
      longtitude: "-0.0810913",
      page: event.page,
      itemCount: 20,
      sort: "distance",
    );

    final stashpointList = (result.items ?? [])
        .map((item) => StashpointItem(
              item.id ?? "",
              item.name ?? "",
            ))
        .toList();

    emit(state.copyWith(
      isLoading: false,
      stashpointList: stashpointList,
      isLastPage: !(result.hasNextPage ?? false),
      currentPage: result.currentPage ?? 0,
    ));
  }
}
