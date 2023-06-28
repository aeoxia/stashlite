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
    on<GetCurrentLocation>(_initialize);
    on<GetStashpointList>(_getStashpointList);
    on<IncreaseCapacity>(_increaseCapacity);
    on<DecreaseCapacity>(_decreaseCapacity);
    on<SetDates>(_setDates);
    on<SortStashpointList>(_sortStashpointList);
    on<SelectLocation>(_selectLocation);
  }

  FutureOr<void> _initialize(
      GetCurrentLocation event, Emitter<StashpointListState> emit) async {
    final result = await _repository.getCurrentLocation();

    emit(state.copyWith(
        selectedLocation: LocationItem(
      "Current Location",
      result.latitude,
      result.longitude,
    )));

    add(const GetStashpointList(page: 1));
  }

  FutureOr<void> _getStashpointList(
      GetStashpointList event, Emitter<StashpointListState> emit) async {
    if (state.selectedLocation == null) return;

    if (state.stashpointList.isEmpty) {
      emit(state.copyWith(isLoading: true));
    }
    final result = await _repository.getStashpoints(
      active: true,
      availability: "all",
      capacity: state.capacity,
      dropOff: state.dropOff,
      pickUp: state.pickUp,
      latitude: state.selectedLocation?.latitude ?? 0.0, //Test: -0.0810913
      longtitude: state.selectedLocation?.longitude ?? 0.0, //Test: -0.0810913
      page: event.page,
      itemCount: 20,
      sort: sortFilter[state.selectedSort]!,
    );

    final stashpointList = (result.items ?? []).map((item) {
      final imageList = item.imageList ?? [];
      final symbol = item.priceStructure?.symbol ?? "";
      final firstDayCost = item.priceStructure?.firstDay ?? "";
      final extraDayCost = item.priceStructure?.extraDay ?? "";
      final showOnePrice = firstDayCost == extraDayCost;
      return StashpointItem(
        id: item.id ?? "",
        name: item.name ?? "",
        image: imageList.isEmpty == true ? "" : imageList.first,
        address: item.address ?? "",
        rating: item.rating.toString(),
        isAlwaysOpen: item.isAlwaysOpen ?? false,
        price: showOnePrice
            ? "$symbol$firstDayCost"
            : "$symbol$firstDayCost - $symbol$extraDayCost",
      );
    }).toList();

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

  FutureOr<void> _sortStashpointList(
      SortStashpointList event, Emitter<StashpointListState> emit) async {
    emit(state.copyWith(
      selectedSort: event.index,
      stashpointList: [],
    ));
    add(const GetStashpointList(page: 1));
  }

  FutureOr<List<LocationItem>> getSuggestions(String address) async {
    if (address.isEmpty) return [];
    return _repository.getLocations(address);
  }

  FutureOr<void> _selectLocation(
      SelectLocation event, Emitter<StashpointListState> emit) async {
    emit(state.copyWith(
      selectedLocation: LocationItem(
        event.name,
        event.latitude,
        event.longitude,
      ),
      stashpointList: [],
    ));
    add(const GetStashpointList(page: 1));
  }
}
