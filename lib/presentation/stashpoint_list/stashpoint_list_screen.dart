import 'dart:ffi';

import 'package:city_stasher_lite/di.dart';
import 'package:city_stasher_lite/presentation/shared/formatter.dart';
import 'package:city_stasher_lite/presentation/shared/page_loader.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_bloc.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_event.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_state.dart';
import 'package:geolocator/geolocator.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';

import '../../styles/colors.dart';

class StashpointListScreen extends StatefulWidget {
  const StashpointListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StashpointListScreenState();
}

class _StashpointListScreenState extends State<StashpointListScreen> {
  final StashpointListBloc _bloc = getIt.get();
  final ScrollController _scrollController = ScrollController();
  final PagingController<int, StashpointItem> _pagingController =
      PagingController(firstPageKey: 0);

  static const _headerTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const _itemHeaderTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const _subHeaderTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const _searchTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const _descriptionTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(255, 59, 59, 59),
  );

  @override
  void initState() {
    initialize();
    super.initState();
  }

  void initialize() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        final isAllowed = await checkLocationPermission(
          onDisabled: () => showSnackBar(
              'Location services are disabled. Please enable the services'),
          onDenied: () => showSnackBar('Location permissions are denied'),
          onDeniedForever: () => showSnackBar(
              'Location permissions are permanently denied, we cannot request permissions.'),
        );

        if (isAllowed) {
          _bloc.add(const Initialize());

          _pagingController.addPageRequestListener((pageKey) {
            _bloc.add(GetStashpointList(page: pageKey + 1));
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<StashpointListBloc, StashpointListState>(
            listener: handleEventChange,
            child: blocBuilder(),
          ),
        ),
      ),
    );
  }

  void handleEventChange(
      BuildContext context, StashpointListState state) async {
    try {
      if (state.isLastPage) {
        _pagingController.appendLastPage(state.stashpointList);
      } else {
        _pagingController.appendPage(state.stashpointList, state.currentPage);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Future<bool> checkLocationPermission({
    required Function() onDisabled,
    required Function() onDenied,
    required Function() onDeniedForever,
  }) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      onDisabled();
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        onDenied();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      onDeniedForever();
      return false;
    }
    return true;
  }

  void showSnackBar(String message) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Widget blocBuilder() {
    return BlocBuilder<StashpointListBloc, StashpointListState>(
      builder: (context, state) {
        return PageLoader(
          isLoading: state.isLoading,
          child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return [headerSection(state)];
              }),
              body: listSection(state)),
        );
      },
    );
  }

  Widget headerSection(StashpointListState state) {
    return SliverAppBar(
      expandedHeight: 350.0,
      backgroundColor: lightContainer,
      flexibleSpace: infoCard(state),
      bottom: appBar(state),
    );
  }

  Widget infoCard(StashpointListState state) {
    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
        color: lightContainer,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              header(),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  dates(state),
                  capacity(state),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "Welcome!",
          style: _headerTextStyle,
        ),
        SvgPicture.asset(
          'assets/images/travelers.svg',
          height: 120,
          fit: BoxFit.scaleDown,
        )
      ],
    );
  }

  Widget dates(StashpointListState state) {
    return InkWell(
      onTap: () async {
        List<DateTime> dateTimeList = await showOmniDateTimeRangePicker(
              context: context,
              startInitialDate: state.dropOff.toDateTime(),
              endInitialDate:
                  state.pickUp.toDateTime(defaultDateTime: nextDayDateTime()),
              theme: ThemeData(
                cardColor: lightContainer,
                colorScheme: const ColorScheme.light(primary: primaryColor),
              ),
            ) ??
            [];
        _bloc.add(SetDates(dropOff: dateTimeList[0], pickUp: dateTimeList[1]));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "from ${state.dropOff.toFormat(outputFormat: uiDateFormat)}",
            style: _subHeaderTextStyle,
          ),
          Text(
            "to ${state.pickUp.toFormat(defaultDateTime: nextDayDateTime(), outputFormat: uiDateFormat)}",
            style: _subHeaderTextStyle,
          ),
        ],
      ),
    );
  }

  Widget capacity(StashpointListState state) {
    return Row(
      children: [
        const SizedBox(
          width: 5,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                _bloc.add(const DecreaseCapacity());
              },
              icon: const Icon(
                Icons.remove_circle,
                color: primaryColor,
                size: 18,
              ),
            ),
            const Icon(
              Icons.luggage_outlined,
              color: primaryColor,
            ),
            Text(
              state.capacity.toString(),
              style: _subHeaderTextStyle,
            ),
            IconButton(
              onPressed: () {
                _bloc.add(const IncreaseCapacity());
              },
              icon: const Icon(
                Icons.add_circle,
                color: primaryColor,
                size: 18,
              ),
            )
          ],
        )
      ],
    );
  }

  PreferredSizeWidget appBar(StashpointListState state) {
    return AppBar(
      flexibleSpace: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchBar(
              leading: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.location_city,
                  color: Colors.white,
                ),
              ),
              trailing: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.my_location,
                    color: Colors.white,
                  ),
                )
              ],
              textStyle: MaterialStateProperty.resolveWith((_) {
                return _searchTextStyle;
              }),
              hintText: state.selectedLocation?.name ?? "Search...",
              backgroundColor: MaterialStateProperty.all(primaryColor),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                value: state.selectedSort,
                items: sortFilter.entries.map((MapEntry<int, String> entry) {
                  return DropdownMenuItem<int>(
                    value: entry.key,
                    child: Text(entry.value),
                  );
                }).toList(),
                onChanged: (selection) {
                  _bloc.add(SortStashpointList(index: selection ?? 0));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listSection(StashpointListState state) {
    return PagedListView<int, StashpointItem>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
        itemBuilder: (context, item, index) {
          return stashpointItem(item);
        },
      ),
    );
  }

  Widget stashpointItem(StashpointItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.image,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.broken_image_rounded,
                      size: 120,
                    );
                  },
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name,
                          style: _itemHeaderTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item.address,
                          style: _subHeaderTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          item.price,
                          style: _descriptionTextStyle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Visibility(
                            visible: item.isAlwaysOpen,
                            child: SvgPicture.asset(
                                "assets/images/twentyfour_seven.svg")),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(item.rating),
                        const Icon(
                          Icons.star_rounded,
                          size: 16,
                        )
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pagingController.dispose();
    super.dispose();
  }
}
