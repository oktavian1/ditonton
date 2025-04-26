import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/movie_usecase/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/movie_usecase/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_state.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_action_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListStatus, SaveWatchlist, RemoveWatchlist])
void main() {
  late MovieDetailActionBloc bloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    bloc = MovieDetailActionBloc(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  const tId = 1;
  final tMovieDetail = testMovieDetail;

  test('initial state should be MMovieDetailActionEmpty', () {
    expect(bloc.state, MMovieDetailActionEmpty());
  });

  blocTest<MovieDetailActionBloc, MovieDetailActionState>(
    'should emit [Message, StatusChanged(true)] when AddToWatchlist succeeds',
    build: () {
      when(mockSaveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(tMovieDetail.id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tMovieDetail)),
    expect: () => [
      MovieDetailActionMessage(
          MovieDetailActionBloc.watchlistAddSuccessMessage),
      MovieWatchlistStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(tMovieDetail));
      verify(mockGetWatchListStatus.execute(tMovieDetail.id));
    },
  );

  blocTest<MovieDetailActionBloc, MovieDetailActionState>(
    'should emit [Message, StatusChanged(true)] when AddToWatchlist succeeds',
    build: () {
      when(mockSaveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatus.execute(tMovieDetail.id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tMovieDetail)),
    expect: () => [
      MovieDetailActionMessage(
          MovieDetailActionBloc.watchlistAddSuccessMessage),
      MovieWatchlistStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockSaveWatchlist.execute(tMovieDetail));
      verify(mockGetWatchListStatus.execute(tMovieDetail.id));
    },
  );

  blocTest<MovieDetailActionBloc, MovieDetailActionState>(
    'should emit [Message, StatusChanged(false)] when RemoveFromWatchlist succeeds',
    build: () {
      when(mockRemoveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      when(mockGetWatchListStatus.execute(tMovieDetail.id))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(tMovieDetail)),
    expect: () => [
      MovieDetailActionMessage(
          MovieDetailActionBloc.watchlistRemoveSuccessMessage),
      MovieWatchlistStatusChanged(false),
    ],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(tMovieDetail));
      verify(mockGetWatchListStatus.execute(tMovieDetail.id));
    },
  );

  blocTest<MovieDetailActionBloc, MovieDetailActionState>(
    'should emit [Error] when RemoveFromWatchlist fails',
    build: () {
      when(mockRemoveWatchlist.execute(tMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);

      return bloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(tMovieDetail)),
    expect: () =>
        [MovieDetailActionError('Failed'), MovieWatchlistStatusChanged(true)],
    verify: (bloc) {
      verify(mockRemoveWatchlist.execute(tMovieDetail));
    },
  );

  blocTest<MovieDetailActionBloc, MovieDetailActionState>(
    'should emit [StatusChanged] when LoadWatchlistStatus called',
    build: () {
      when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [
      MovieWatchlistStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListStatus.execute(tId));
    },
  );
}
