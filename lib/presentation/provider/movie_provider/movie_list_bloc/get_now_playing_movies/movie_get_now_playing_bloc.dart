import 'package:ditonton/domain/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_now_playing_movies/movie_get_now_playing_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_now_playing_movies/movie_get_now_playing_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieGetNowPlayingBloc
    extends Bloc<MovieGetNowPlayingEvent, MovieGetNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  MovieGetNowPlayingBloc(
    this.getNowPlayingMovies,
  ) : super(MovieGetNowPlayingEmpty()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(MovieGetNowPlayingLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) => emit(MovieGetNowPlayingError(failure.message)),
        (data) => emit(MovieGetNowPlayingHasData(data)),
      );
    });
  }
}
