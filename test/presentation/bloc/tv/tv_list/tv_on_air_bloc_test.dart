import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_on_air_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_on_air_bloc_test.mocks.dart';

@GenerateMocks([GetOnAirTv])
void main() {
  late TvOnAirBloc tvOnAirBloc;
  late MockGetOnAirTv mockGetOnAirTv;

  setUp(() {
    mockGetOnAirTv = MockGetOnAirTv();
    tvOnAirBloc = TvOnAirBloc(mockGetOnAirTv);
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
    expect(tvOnAirBloc.state, TvOnAirEmpty());
  });

  blocTest<TvOnAirBloc, TvOnAirState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnAirTv.execute()).thenAnswer((_) async => Right(testTvList));
      return tvOnAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvOnAir()),
    expect: () => [
      TvOnAirLoading(),
      TvOnAirHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetOnAirTv.execute());
    },
  );

  blocTest<TvOnAirBloc, TvOnAirState>(
    'should emit [Loading, Error] when getting data fails',
    build: () {
      when(mockGetOnAirTv.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvOnAirBloc;
    },
    act: (bloc) => bloc.add(FetchTvOnAir()),
    expect: () => [
      TvOnAirLoading(),
      TvOnAirError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnAirTv.execute());
    },
  );
}
