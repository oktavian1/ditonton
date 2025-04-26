import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/tv_usecase/get_watch_list_tv_status.dart';
import 'package:ditonton/domain/usecases/tv_usecase/remove_tv.dart';
import 'package:ditonton/domain/usecases/tv_usecase/save_tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_event.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_action_bloc_test.mocks.dart';

@GenerateMocks([GetWatchListTvStatus, SaveTv, RemoveTv])
void main() {
  late TvDetailActionBloc bloc;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late MockSaveTv mockSaveTv;
  late MockRemoveTv mockRemoveTv;

  setUp(() {
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    mockSaveTv = MockSaveTv();
    mockRemoveTv = MockRemoveTv();
    bloc = TvDetailActionBloc(
      mockSaveTv,
      mockRemoveTv,
      mockGetWatchListTvStatus,
    );
  });

  const tId = 1;
  final tTvDetail = testTvDetail;

  test('initial state should be TvDetailActionEmpty', () {
    expect(bloc.state, TvDetailActionEmpty());
  });

  blocTest<TvDetailActionBloc, TvDetailActionState>(
    'should emit [Message, StatusChanged(true)] when AddToWatchlist succeeds',
    build: () {
      when(mockSaveTv.execute(tTvDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListTvStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(AddToWatchlist(tTvDetail)),
    expect: () => [
      TvDetailActionMessage(TvDetailActionBloc.watchlistAddSuccessMessage),
      TvDetailActionStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockSaveTv.execute(tTvDetail));
      verify(mockGetWatchListTvStatus.execute(tTvDetail.id));
    },
  );

  blocTest<TvDetailActionBloc, TvDetailActionState>(
    'should emit [Message, StatusChanged(false)] when RemoveFromWatchlist succeeds',
    build: () {
      when(mockRemoveTv.execute(tTvDetail))
          .thenAnswer((_) async => const Right('Removed from Watchlist'));
      when(mockGetWatchListTvStatus.execute(tTvDetail.id))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(tTvDetail)),
    expect: () => [
      TvDetailActionMessage(TvDetailActionBloc.watchlistRemoveSuccessMessage),
      TvDetailActionStatusChanged(false),
    ],
    verify: (bloc) {
      verify(mockRemoveTv.execute(tTvDetail));
      verify(mockGetWatchListTvStatus.execute(tTvDetail.id));
    },
  );

  blocTest<TvDetailActionBloc, TvDetailActionState>(
    'should emit [Error, StatusChanged(true)] when RemoveFromWatchlist fails',
    build: () {
      when(mockRemoveTv.execute(tTvDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchListTvStatus.execute(tId)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(RemoveFromWatchlist(tTvDetail)),
    expect: () => [
      TvDetailActionError('Failed'),
      TvDetailActionStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockRemoveTv.execute(tTvDetail));
      verify(mockGetWatchListTvStatus.execute(tId));
    },
  );

  blocTest<TvDetailActionBloc, TvDetailActionState>(
    'should emit [StatusChanged] when LoadWatchlistStatus called',
    build: () {
      when(mockGetWatchListTvStatus.execute(tId)).thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
    expect: () => [
      TvDetailActionStatusChanged(true),
    ],
    verify: (bloc) {
      verify(mockGetWatchListTvStatus.execute(tId));
    },
  );
}
