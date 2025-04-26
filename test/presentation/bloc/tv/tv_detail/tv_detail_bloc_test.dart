import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_recomendation_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail, GetRecomendationTv])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetRecomendationTv mockGetRecomendationTv;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetRecomendationTv = MockGetRecomendationTv();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail, mockGetRecomendationTv);
  });

  final tId = 1;

  final testTv = Tv(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man: The Series',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final testTvList = <Tv>[testTv];

  void _arrangeUsecase() {
    when(mockGetTvDetail.execute(tId))
        .thenAnswer((_) async => Right(testTvDetail));
    when(mockGetRecomendationTv.execute(tId))
        .thenAnswer((_) async => Right(testTvList));
  }

  test('initial state should be empty', () {
    expect(tvDetailBloc.state, TvDetailEmpty());
  });

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      _arrangeUsecase();
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(tId)),
    wait: const Duration(milliseconds: 100),
    expect: () => [
      TvDetailLoading(),
      TvDetailHasData(tv: testTvDetail, recommendations: testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetRecomendationTv.execute(tId));
    },
  );

  blocTest<TvDetailBloc, TvDetailState>(
    'Should emit [Loading, Error] when get detail is unsuccessful',
    build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetRecomendationTv.execute(tId))
          .thenAnswer((_) async => Right(testTvList));
      return tvDetailBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetail(tId)),
    expect: () => [
      TvDetailLoading(),
      TvDetailError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetRecomendationTv.execute(tId));
    },
  );
}
