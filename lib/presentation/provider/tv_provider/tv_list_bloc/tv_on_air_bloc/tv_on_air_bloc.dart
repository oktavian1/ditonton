import 'package:ditonton/domain/usecases/tv_usecase/get_on_air_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvOnAirBloc extends Bloc<TvOnAirEvent, TvOnAirState> {
  final GetOnAirTv getOnAirTv;

  TvOnAirBloc(
    this.getOnAirTv,
  ) : super(TvOnAirEmpty()) {
    on<FetchTvOnAir>((event, emit) async {
      emit(TvOnAirLoading());
      final result = await getOnAirTv.execute();
      result.fold(
        (failure) => emit(TvOnAirError(failure.message)),
        (data) => emit(TvOnAirHasData(data)),
      );
    });
  }
}
