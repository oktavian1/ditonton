import 'package:ditonton/domain/usecases/movie_usecase/get_top_rated_movies.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_top_rated_movies/movie_get_top_rated_state.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_top_rated_movies/movie_get_top_rated_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieGetTopRatedBloc
    extends Bloc<MovieGetTopRatedEvent, MovieGetTopRatedState> {
  final GetTopRatedMovies getTopRatedMovies;

  MovieGetTopRatedBloc(
    this.getTopRatedMovies,
  ) : super(MovieGetTopRatedEmpty()) {
    on<FetchTopRatedMovies>((event, emit) async {
      emit(MovieGetTopRatedLoading());
      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) => emit(MovieGetTopRatedError(failure.message)),
        (data) => emit(MovieGetTopRatedHasData(data)),
      );
    });
  }
}
