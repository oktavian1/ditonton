import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TvTopRatedNotifier extends ChangeNotifier {
  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;

  String _message = '';
  String get message => _message;

  TvTopRatedNotifier({
    required this.getTopRatedTv,
  });

  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchGetTopRatedTv() async {
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
}
