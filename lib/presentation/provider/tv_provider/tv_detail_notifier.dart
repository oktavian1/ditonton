import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_recomendation_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_watch_list_tv_status.dart';
import 'package:ditonton/domain/usecases/tv_usecase/remove_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/save_tv.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final GetTvDetail getTvDetail;
  final GetRecomendationTv getRecomendationTv;
  final SaveTv saveTv;
  final RemoveTv removeTv;
  final GetWatchListTvStatus getWatchListStatus;

  TvDetailNotifier({
    required this.getTvDetail,
    required this.getRecomendationTv,
    required this.saveTv,
    required this.removeTv,
    required this.getWatchListStatus,
  });

  late TvDetail _tv;
  TvDetail get tv => _tv;

  RequestState _tvState = RequestState.Empty;
  RequestState get tvState => _tvState;

  List<Tv> _tvRecomendation = [];
  List<Tv> get tvRecomendation => _tvRecomendation;

  RequestState _tvRecomendationState = RequestState.Empty;
  RequestState get tvRecomendationState => _tvRecomendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvDetail(int id) async {
    _tvState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recomendationResult = await getRecomendationTv.execute(id);

    detailResult.fold(
      (failure) {
        _tvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvData) {
        _tvRecomendationState = RequestState.Loading;
        _tv = tvData;
        notifyListeners();
        recomendationResult.fold(
          (failure) {
            _tvRecomendationState = RequestState.Error;
            _message = failure.message;
          },
          (tvDataRecomendation) {
            _tvRecomendationState = RequestState.Loaded;
            _tvRecomendation = tvDataRecomendation;
          },
        );
        _tvState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail movie) async {
    final result = await saveTv.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(TvDetail movie) async {
    final result = await removeTv.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
