import 'package:ditonton/presentation/pages/movie_detail/movie_detail_content.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_state.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(FetchMovieDetail(widget.id));
      context.read<MovieDetailActionBloc>().add(LoadWatchlistStatus(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MovieDetailActionBloc, MovieDetailActionState>(
            listener: (context, state) {
              if (state is MovieDetailActionMessage) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is MovieDetailActionError) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Error'),
                    content: Text(state.message),
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailHasData) {
              final movie = state.movie;
              final recommendations = state.recommendations;

              return BlocBuilder<MovieDetailActionBloc, MovieDetailActionState>(
                builder: (context, actionState) {
                  final isAddedToWatchlist =
                      actionState is MovieWatchlistStatusChanged
                          ? actionState.isAdded
                          : false;

                  return SafeArea(
                    child: MovieDetailContent(
                      movie: movie,
                      recommendations: recommendations,
                      isAddedWatchlist: isAddedToWatchlist,
                    ),
                  );
                },
              );
            } else if (state is MovieDetailError) {
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
