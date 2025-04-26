import 'package:ditonton/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  final GetPopularTv getPopularTv;

  TvPopularBloc(
    this.getPopularTv,
  ) : super(TvPopularEmpty()) {
    on<FetchTvPopular>((event, emit) async {
      emit(TvPopularLoading());
      final result = await getPopularTv.execute();
      result.fold(
        (failure) => emit(TvPopularError(failure.message)),
        (data) => emit(TvPopularHasData(data)),
      );
    });
  }
}
