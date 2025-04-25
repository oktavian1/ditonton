import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_recomendation_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_watch_list_tv_status.dart';
import 'package:ditonton/domain/usecases/tv_usecase/remove_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/save_tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetRecomendationTv,
  SaveTv,
  RemoveTv,
  GetWatchListTvStatus,
])
void main() {
  late TvDetailNotifier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetRecomendationTv mockGetRecomendationTv;
  late MockSaveTv mockSaveTv;
  late MockRemoveTv mockRemoveTv;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetRecomendationTv = MockGetRecomendationTv();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockSaveTv = MockSaveTv();
    mockRemoveTv = MockRemoveTv();
    provider = TvDetailNotifier(
      getTvDetail: mockGetTvDetail,
      getRecomendationTv: mockGetRecomendationTv,
      getWatchListStatus: mockGetWatchListTvStatus,
      saveTv: mockSaveTv,
      removeTv: mockRemoveTv,
    )..addListener(() {
        listenerCallCount += 1;
      });
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

  group('Get tv Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetTvDetail.execute(tId));
      verify(mockGetRecomendationTv.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change movie when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Loaded);
      expect(provider.tvRecomendation, testTvList);
    });
  });

  group('Get tv Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      verify(mockGetRecomendationTv.execute(tId));
      expect(provider.tvRecomendation, testTvList);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvRecomendationState, RequestState.Loaded);
      expect(provider.tvRecomendation, testTvList);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      when(mockGetRecomendationTv.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvRecomendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListTvStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockSaveTv.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveTv.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTv.execute(testTvDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      verify(mockGetWatchListTvStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTv.execute(testTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListTvStatus.execute(testTvDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetRecomendationTv.execute(tId))
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchTvDetail(tId);
      // assert
      expect(provider.tvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
