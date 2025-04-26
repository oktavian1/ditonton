import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_top_rated_movies/movie_get_top_rated_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_top_rated_movies/movie_get_top_rated_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_top_rated_movies/movie_get_top_rated_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    context.read<MovieGetTopRatedBloc>().add(FetchTopRatedMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieGetTopRatedBloc, MovieGetTopRatedState>(
          builder: (context, state) {
            if (state is MovieGetTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MovieGetTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            } else if (state is MovieGetTopRatedError) {
              return Center(
                  child: Text(key: Key('error_message'), state.message));
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
