import 'package:ditonton/domain/usecases/tv_usecase/get_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetWatchlistTv getWatchlistTv;

  TvWatchlistBloc(
    this.getWatchlistTv,
  ) : super(TvWatchlistEmpty()) {
    on<FetchTvWatchlist>((event, emit) async {
      emit(TvWatchlistLoading());
      final result = await getWatchlistTv.execute();
      result.fold(
        (failure) => emit(TvWatchlistError(failure.message)),
        (data) => emit(TvWatchlistHasData(data)),
      );
    });
  }
}
