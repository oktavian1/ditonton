import 'package:ditonton/domain/usecases/tv_usecase/get_top_rated_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_top_rated_bloc/tv_top_rated_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_top_rated_bloc/tv_top_rated_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  final GetTopRatedTv getTopRatedTv;

  TvTopRatedBloc(
    this.getTopRatedTv,
  ) : super(TvTopRatedEmpty()) {
    on<FetchTvTopRated>((event, emit) async {
      emit(TvTopRatedLoading());
      final result = await getTopRatedTv.execute();
      result.fold(
        (failure) => emit(TvTopRatedError(failure.message)),
        (data) => emit(TvTopRatedHasData(data)),
      );
    });
  }
}
