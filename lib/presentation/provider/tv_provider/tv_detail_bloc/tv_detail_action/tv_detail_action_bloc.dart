import 'package:ditonton/domain/usecases/tv_usecase/get_watch_list_tv_status.dart';
import 'package:ditonton/domain/usecases/tv_usecase/remove_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/save_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailActionBloc
    extends Bloc<TvDetailActionEvent, TvDetailActionState> {
  final GetWatchListTvStatus getWatchListTvStatus;
  final SaveTv saveTv;
  final RemoveTv removeTv;
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  TvDetailActionBloc(
    this.saveTv,
    this.removeTv,
    this.getWatchListTvStatus,
  ) : super(TvDetailActionEmpty()) {
    on<AddToWatchlist>(_onAddToWatchlist);
    on<RemoveFromWatchlist>(_onRemoveFromWatchlist);
    on<LoadWatchlistStatus>(_onLoadWatchlistStatus);
  }

  Future<void> _onAddToWatchlist(
    AddToWatchlist event,
    Emitter<TvDetailActionState> emit,
  ) async {
    final result = await saveTv.execute(event.tvDetail);
    result.fold(
      (failure) => emit(TvDetailActionError(failure.message)),
      (message) => emit(TvDetailActionMessage(watchlistAddSuccessMessage)),
    );
    final isAdded = await getWatchListTvStatus.execute(event.tvDetail.id);
    emit(TvDetailActionStatusChanged(isAdded));
  }

  Future<void> _onRemoveFromWatchlist(
    RemoveFromWatchlist event,
    Emitter<TvDetailActionState> emit,
  ) async {
    final result = await removeTv.execute(event.tvDetail);

    result.fold(
      (failure) => emit(TvDetailActionError(failure.message)),
      (message) => emit(
        TvDetailActionMessage(watchlistRemoveSuccessMessage),
      ),
    );
    final isAdded = await getWatchListTvStatus.execute(event.tvDetail.id);
    emit(TvDetailActionStatusChanged(isAdded));
  }

  Future<void> _onLoadWatchlistStatus(
    LoadWatchlistStatus event,
    Emitter<TvDetailActionState> emit,
  ) async {
    final isAdded = await getWatchListTvStatus.execute(event.id);
    emit(TvDetailActionStatusChanged(isAdded));
  }
}
