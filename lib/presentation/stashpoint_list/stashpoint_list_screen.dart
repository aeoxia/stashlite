import 'package:city_stasher_lite/di.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_bloc.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_event.dart';
import 'package:city_stasher_lite/presentation/stashpoint_list/stashpoint_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StashpointListScreen extends StatefulWidget {
  const StashpointListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _StashpointListScreenState();
}

class _StashpointListScreenState extends State<StashpointListScreen> {
  final StashpointListBloc _bloc = getIt.get();

  @override
  void initState() {
    _bloc.add(const GetStashpointList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<StashpointListBloc, StashpointListState>(
            listener: (context, state) {},
            child: BlocBuilder<StashpointListBloc, StashpointListState>(
              builder: (context, state) {
                return ListView.builder(
                  itemCount: state.stashpointList.length,
                  itemBuilder: (context, index) {
                    final item = state.stashpointList[index];
                    return Text(item.name);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
