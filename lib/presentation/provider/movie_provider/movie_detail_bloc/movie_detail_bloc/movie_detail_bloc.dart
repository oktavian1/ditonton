import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_movie_recommendations.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailBloc(
    this.getMovieDetail,
    this.getMovieRecommendations,
  ) : super(MovieDetailEmpty()) {
    on<FetchMovieDetail>(_onFetchMovieDetail);
  }

  Future<void> _onFetchMovieDetail(
      FetchMovieDetail event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());

    final detailResult = await getMovieDetail.execute(event.id);
    final recommendationResult =
        await getMovieRecommendations.execute(event.id);

    detailResult.fold(
      (failure) => emit(MovieDetailError(failure.message)),
      (movie) {
        recommendationResult.fold(
          (failure) => emit(MovieDetailError(failure.message)),
          (recommendations) async {
            emit(
              MovieDetailHasData(
                movie: movie,
                recommendations: recommendations,
              ),
            );
          },
        );
      },
    );
  }
}
