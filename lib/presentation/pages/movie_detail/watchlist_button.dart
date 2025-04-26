import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistButton extends StatelessWidget {
  final MovieDetail movie;
  final bool isAddedWatchlist;

  const WatchlistButton({
    required this.movie,
    required this.isAddedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (!isAddedWatchlist) {
          context.read<MovieDetailActionBloc>().add(AddToWatchlist(movie));
        } else {
          context.read<MovieDetailActionBloc>().add(RemoveFromWatchlist(movie));
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isAddedWatchlist ? Icons.check : Icons.add),
          const SizedBox(width: 4),
          const Text('Watchlist'),
        ],
      ),
    );
  }
}
