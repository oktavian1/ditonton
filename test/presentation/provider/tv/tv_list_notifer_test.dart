import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_on_air_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_popular_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_top_rated_tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_notifer.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_list_notifer_test.mocks.dart';

@GenerateMocks([GetPopularTv, GetTopRatedTv, GetOnAirTv])
void main() {
  late TvListNotifier provider;
  late MockGetPopularTv mockGetPopularTv;
  late MockGetTopRatedTv mockGetTopRatedTv;
  late MockGetOnAirTv mockGetOnAirTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTv = MockGetPopularTv();
    mockGetTopRatedTv = MockGetTopRatedTv();
    mockGetOnAirTv = MockGetOnAirTv();
    provider = TvListNotifier(
      getPopularTv: mockGetPopularTv,
      getTopRatedTv: mockGetTopRatedTv,
      getOnAirTv: mockGetOnAirTv,
    )..addListener(() {
        listenerCallCount += 1;
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

  group('Popular tv', () {
    test('initialState should be Empty', () {
      expect(provider.popularTvState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTvPopularTv();
      // assert
      verify(mockGetPopularTv.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTvPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchTvPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Loaded);
      expect(provider.popularTv, testTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvPopularTv();
      // assert
      expect(provider.popularTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Loaded);
      expect(provider.topRatedTv, testTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTv();
      // assert
      expect(provider.topRatedTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('On Air TV', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetOnAirTv.execute()).thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchOnAirTv();
      // assert
      expect(provider.onAirTvState, RequestState.Loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetOnAirTv.execute()).thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchOnAirTv();
      // assert
      expect(provider.onAirTvState, RequestState.Loaded);
      expect(provider.onAirTv, testTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnAirTv();
      // assert
      expect(provider.onAirTvState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
