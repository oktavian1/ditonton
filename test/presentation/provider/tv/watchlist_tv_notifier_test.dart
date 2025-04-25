import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/watchlist_tv_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_tv_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTv])
void main() {
  late MockGetWatchlistTv mockGetWatchlistTv;
  late WatchlistTvNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTv = MockGetWatchlistTv();
    notifier = WatchlistTvNotifier(getWatchlistTv: mockGetWatchlistTv)
      ..addListener(() {
        listenerCallCount++;
      });
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

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetWatchlistTv.execute())
        .thenAnswer((_) async => Right(testTvList));
    // act
    notifier.fetchWatchlistMovies();
    // assert
    expect(notifier.watchlistTvState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change movies data when data is gotten successfully', () async {
    // arrange
    when(mockGetWatchlistTv.execute())
        .thenAnswer((_) async => Right(testTvList));
    // act
    await notifier.fetchWatchlistMovies();
    // assert
    expect(notifier.watchlistTvState, RequestState.Loaded);
    expect(notifier.watchlistTv, testTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTv.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchWatchlistMovies();
    // assert
    expect(notifier.watchlistTvState, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
