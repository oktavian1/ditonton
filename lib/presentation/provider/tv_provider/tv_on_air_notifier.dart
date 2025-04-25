import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_on_air_tv.dart';
import 'package:flutter/material.dart';

class TvOnAirNotifier extends ChangeNotifier {
  var _onAirTv = <Tv>[];
  List<Tv> get onAirTv => _onAirTv;

  RequestState _onAirTvState = RequestState.Empty;
  RequestState get onAirTvState => _onAirTvState;

  String _message = '';
  String get message => _message;

  TvOnAirNotifier({
    required this.getOnAirTv,
  });

  final GetOnAirTv getOnAirTv;

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
