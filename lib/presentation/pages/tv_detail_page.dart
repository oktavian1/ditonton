import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_state.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ditonton/presentation/widgets/tv_detail_view.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-detail';
  final int id;

  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(FetchTvDetail(widget.id));
      context.read<TvDetailActionBloc>().add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<TvDetailActionBloc, TvDetailActionState>(
            listener: (context, state) {
              if (state is TvDetailActionMessage) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.message)));
              } else if (state is TvDetailActionError) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(state.message),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TvDetailHasData) {
              final tv = state.tv;
              final recommendations = state.recommendations;

              return BlocBuilder<TvDetailActionBloc, TvDetailActionState>(
                builder: (context, actionState) {
                  final isAddedToWatchlist =
                      actionState is TvDetailActionStatusChanged
                          ? actionState.isAdded
                          : false;

                  return SafeArea(
                    child: TvDetailView(
                      tv: tv,
                      recommendations: recommendations,
                      isAddedWatchlist: isAddedToWatchlist,
                    ),
                  );
                },
              );
            } else if (state is TvDetailError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Something went wrong'));
            }
          },
        ),
      ),
    );
  }
}
