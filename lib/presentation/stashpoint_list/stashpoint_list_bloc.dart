import 'dart:async';

import 'package:city_stasher_lite/data/city_stasher_repository.dart';
import 'package:city_stasher_lite/presentation/shared/formatter.dart';
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
    on<IncreaseCapacity>(_increaseCapacity);
    on<DecreaseCapacity>(_decreaseCapacity);
    on<SetDates>(_setDates);
  }

  FutureOr<void> _getStashpointList(
      GetStashpointList event, Emitter<StashpointListState> emit) async {
    if (state.stashpointList.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }
    final result = await _repository.getStashpoints(
      active: true,
      availability: "all",
      capacity: state.capacity,
      dropOff: state.dropOff,
      pickUp: state.pickUp,
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

  FutureOr<void> _increaseCapacity(
      IncreaseCapacity event, Emitter<StashpointListState> emit) async {
    emit(state.copyWith(
      capacity: state.capacity + 1,
      stashpointList: [],
    ));
    add(const GetStashpointList(page: 1));
  }

  FutureOr<void> _decreaseCapacity(
      DecreaseCapacity event, Emitter<StashpointListState> emit) async {
    if (state.capacity > 1) {
      emit(state.copyWith(
        capacity: state.capacity - 1,
        stashpointList: [],
      ));
      add(const GetStashpointList(page: 1));
    }
  }

  FutureOr<void> _setDates(
      SetDates event, Emitter<StashpointListState> emit) async {
    emit(state.copyWith(
        dropOff: event.dropOff.toDateString(),
        pickUp: event.pickUp.toDateString(),
        stashpointList: []));
    add(const GetStashpointList(page: 1));
  }
}
