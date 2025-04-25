import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:flutter/material.dart';

class TvPopularNotifer extends ChangeNotifier {
  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  String _message = '';
  String get message => _message;

  TvPopularNotifer({
    required this.getPopularTv,
  });

  final GetPopularTv getPopularTv;

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
}
