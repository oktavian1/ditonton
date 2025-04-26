import 'package:ditonton/domain/usecases/tv_usecase/get_recomendation_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvDetail getTvDetail;
  final GetRecomendationTv getRecomendationTv;

  TvDetailBloc(
    this.getTvDetail,
    this.getRecomendationTv,
  ) : super(TvDetailEmpty()) {
    on<FetchTvDetail>(_onFetchTvDetail);
  }

  Future<void> _onFetchTvDetail(
      FetchTvDetail event, Emitter<TvDetailState> emit) async {
    emit(TvDetailLoading());

    final detailResult = await getTvDetail.execute(event.id);
    final recommendationResult = await getRecomendationTv.execute(event.id);

    detailResult.fold(
      (failure) => emit(TvDetailError(failure.message)),
      (tv) {
        recommendationResult.fold(
          (failure) => emit(TvDetailError(failure.message)),
          (recommendations) async {
            emit(
              TvDetailHasData(
                tv: tv,
                recommendations: recommendations,
              ),
            );
          },
        );
      },
    );
  }
}
