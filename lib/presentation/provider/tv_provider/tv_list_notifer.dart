import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_on_air_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TvListNotifier extends ChangeNotifier {
  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  var _onAirTv = <Tv>[];
  List<Tv> get onAirTv => _onAirTv;

  RequestState _onAirTvState = RequestState.Empty;
  RequestState get onAirTvState => _onAirTvState;

  String _message = '';
  String get message => _message;

  TvListNotifier({
    required this.getPopularTv,
    required this.getTopRatedTv,
    required this.getOnAirTv,
  });

  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;
  final GetOnAirTv getOnAirTv;

  Future<void> fetchTvPopularTv() async {
    _popularTvState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();
    result.fold(
      (failure) {
        _popularTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _popularTvState = RequestState.Loaded;

        _popularTv = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();
    result.fold(
      (failure) {
        _topRatedTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _topRatedTvState = RequestState.Loaded;

        _topRatedTv = tvsData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchOnAirTv() async {
    _onAirTvState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTv.execute();
    result.fold(
      (failure) {
        _onAirTvState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvsData) {
        _onAirTvState = RequestState.Loaded;

        _onAirTv = tvsData;
        notifyListeners();
      },
    );
  }
}
