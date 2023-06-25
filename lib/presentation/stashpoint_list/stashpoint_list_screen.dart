import 'package:city_stasher_lite/di.dart';
import 'package:city_stasher_lite/presentation/shared/page_loader.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_bloc.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_event.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  static const _subHeaderTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.black,
  );

  static const _searchTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );

  static const _descriptionTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _bloc.add(GetStashpointList(page: pageKey + 1));
    });

    super.initState();
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

  void handleEventChange(BuildContext context, StashpointListState state) {
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

  Widget blocBuilder() {
    return BlocBuilder<StashpointListBloc, StashpointListState>(
      builder: (context, state) {
        return PageLoader(
          isLoading: state.isLoading,
          child: NestedScrollView(
              controller: _scrollController,
              headerSliverBuilder: ((context, innerBoxIsScrolled) {
                return [headerSection()];
              }),
              body: listSection()),
        );
      },
    );
  }

  Widget headerSection() {
    return SliverAppBar(
      expandedHeight: 300.0,
      backgroundColor: lightContainer,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: Center(
          child: Container(
            color: lightContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Welcome!",
                        style: _headerTextStyle,
                      ),
                      SvgPicture.asset(
                        'assets/images/travelers.svg',
                        height: 120,
                        fit: BoxFit.scaleDown,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "from Mar 3, 04:30 AM",
                        style: _subHeaderTextStyle,
                      ),
                      Row(
                        children: [
                          Text(
                            "2",
                            style: _subHeaderTextStyle,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.trolley,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    "to Mar 3, 04:30 AM",
                    style: _subHeaderTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottom: AppBar(
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SearchBar(
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
            hintText: "Current Location",
            backgroundColor: MaterialStateProperty.all(primaryColor),
          ),
        ),
      ),
    );
  }

  Widget listSection() {
    return PagedListView<int, StashpointItem>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate(
        newPageProgressIndicatorBuilder: (context) => const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        ),
        itemBuilder: (context, item, index) {
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Text(item.name),
          );
        },
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
