import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_watchlist_bloc/tv_watchlist_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_watch_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    tvWatchlistBloc = TvWatchlistBloc(mockGetWatchlistTv);
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
    expect(tvWatchlistBloc.state, TvWatchlistEmpty());
  });

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvWatchlist()),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );

  blocTest<TvWatchlistBloc, TvWatchlistState>(
    'should emit [Loading, Error] when getting data is unsuccessful',
    build: () {
      when(mockGetWatchlistTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvWatchlistBloc;
    },
    act: (bloc) => bloc.add(FetchTvWatchlist()),
    expect: () => [
      TvWatchlistLoading(),
      TvWatchlistError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTv.execute());
    },
  );
}
