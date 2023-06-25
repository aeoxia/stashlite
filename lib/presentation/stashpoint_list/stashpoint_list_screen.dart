import 'package:city_stasher_lite/di.dart';
import 'package:city_stasher_lite/presentation/shared/page_loader.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_bloc.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_event.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
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
            listener: (context, state) {
              try {
                if (state.isLastPage) {
                  _pagingController.appendLastPage(state.stashpointList);
                } else {
                  _pagingController.appendPage(
                      state.stashpointList, state.currentPage);
                }
              } catch (error) {
                _pagingController.error = error;
              }
            },
            child: BlocBuilder<StashpointListBloc, StashpointListState>(
                builder: (context, state) {
              return PageLoader(
                isLoading: state.isLoading,
                child: NestedScrollView(
                  controller: _scrollController,
                  headerSliverBuilder: ((context, innerBoxIsScrolled) {
                    return [SliverAppBar()];
                  }),
                  body: PagedListView<int, StashpointItem>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate(
                      newPageProgressIndicatorBuilder: (context) =>
                          const Center(
                        child: CircularProgressIndicator(
                          color: loader,
                        ),
                      ),
                      itemBuilder: (context, item, index) {
                        return Padding(
                          padding: const EdgeInsets.all(24),
                          child: Text(item.name),
                        );
                      },
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
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
