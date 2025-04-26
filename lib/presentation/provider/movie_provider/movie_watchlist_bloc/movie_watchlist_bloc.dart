import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_movies.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_watchlist_bloc/movie_watchlist_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_watchlist_bloc/movie_watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieWatchlistBloc
    extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetWatchlistMovies getWatchlistMovies;

  MovieWatchlistBloc(
    this.getWatchlistMovies,
  ) : super(MovieWatchlistEmpty()) {
    on<FetchWatchListMovies>((event, emit) async {
      emit(MovieWatchlistLoading());
      final result = await getWatchlistMovies.execute();
      result.fold(
        (failure) => emit(MovieWatchlistError(failure.message)),
        (data) => emit(MovieWatchlistHasData(data)),
      );
    });
  }
}
