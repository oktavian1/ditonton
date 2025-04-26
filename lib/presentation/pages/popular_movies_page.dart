import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<MovieGetPopularBloc>().add(FetchPopularMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<MovieGetPopularBloc, MovieGetPopularState>(
          builder: (context, state) {
            if (state is MoviePopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MoviePopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            } else if (state is MoviePopularError) {
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
