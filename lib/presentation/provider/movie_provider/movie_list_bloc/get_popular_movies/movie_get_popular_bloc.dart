import 'package:ditonton/domain/usecases/movie_usecase/get_popular_movies.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieGetPopularBloc
    extends Bloc<MovieGetPopularEvent, MovieGetPopularState> {
  final GetPopularMovies getPopularMovies;

  MovieGetPopularBloc(
    this.getPopularMovies,
  ) : super(MoviePopularEmpty()) {
    on<FetchPopularMovies>((event, emit) async {
      emit(MoviePopularLoading());
      final result = await getPopularMovies.execute();
      result.fold(
        (failure) => emit(MoviePopularError(failure.message)),
        (data) => emit(MoviePopularHasData(data)),
      );
    });
  }
}
