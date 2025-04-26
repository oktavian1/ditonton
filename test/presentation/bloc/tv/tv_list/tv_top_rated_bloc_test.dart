import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late TvPopularBloc tvPopularBloc;
  late MockGetPopularTv mockGetPopularTv;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    tvPopularBloc = TvPopularBloc(mockGetPopularTv);
  });

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

  test('initial state should be empty', () {
    expect(tvPopularBloc.state, TvPopularEmpty());
  });

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(FetchTvPopular()),
    expect: () => [
      TvPopularLoading(),
      TvPopularHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );

  blocTest<TvPopularBloc, TvPopularState>(
    'should emit [Loading, Error] when getting data fails',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvPopularBloc;
    },
    act: (bloc) => bloc.add(FetchTvPopular()),
    expect: () => [
      TvPopularLoading(),
      TvPopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}
