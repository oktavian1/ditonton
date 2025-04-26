import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecase/save_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecase/remove_watchlist.dart';

class MovieDetailActionBloc
    extends Bloc<MovieDetailActionEvent, MovieDetailActionState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  MovieDetailActionBloc(
    this.getWatchListStatus,
    this.saveWatchlist,
    this.removeWatchlist,
  ) : super(MMovieDetailActionEmpty()) {
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onAddToWatchlist(
    AddToWatchlist event,
    Emitter<MovieDetailActionState> emit,
  ) async {
    final result = await saveWatchlist.execute(event.movieDetail);
    result.fold(
      (failure) => emit(MovieDetailActionError(failure.message)),
      (message) => emit(MovieDetailActionMessage(watchlistAddSuccessMessage)),
    );
    final isAdded = await getWatchListStatus.execute(event.movieDetail.id);
    emit(MovieWatchlistStatusChanged(isAdded));
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<MovieDetailActionState> emit,
  ) async {
    final result = await removeWatchlist.execute(event.movieDetail);

    result.fold(
      (failure) => emit(MovieDetailActionError(failure.message)),
      (message) => emit(
        MovieDetailActionMessage(watchlistRemoveSuccessMessage),
      ),
    );
    final isAdded = await getWatchListStatus.execute(event.movieDetail.id);
    emit(MovieWatchlistStatusChanged(isAdded));
  }

  Future<void> _onLoadWatchlistStatus(
    LoadWatchlistStatus event,
    Emitter<MovieDetailActionState> emit,
  ) async {
    final isAdded = await getWatchListStatus.execute(event.id);
    emit(MovieWatchlistStatusChanged(isAdded));
  }
}
