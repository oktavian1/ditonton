import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_state.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_bloc/tv_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailBloc, TvDetailActionBloc])
void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvDetailActionBloc mockTvDetailActionBloc;

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvDetailActionBloc = MockTvDetailActionBloc();
    when(mockTvDetailBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockTvDetailActionBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>.value(value: mockTvDetailBloc),
        BlocProvider<TvDetailActionBloc>.value(value: mockTvDetailActionBloc),
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when not added to watchlist',
    (WidgetTester tester) async {
      when(mockTvDetailBloc.state).thenReturn(
        TvDetailHasData(
          tv: testTvDetail,
          recommendations: const [],
        ),
      );
      when(mockTvDetailActionBloc.state)
          .thenReturn(TvDetailActionStatusChanged(false));

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display check icon when added to watchlist',
    (WidgetTester tester) async {
      when(mockTvDetailBloc.state).thenReturn(
        TvDetailHasData(
          tv: testTvDetail,
          recommendations: const [],
        ),
      );
      when(mockTvDetailActionBloc.state)
          .thenReturn(TvDetailActionStatusChanged(true));

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);
    },
  );

  testWidgets(
    'Should show SnackBar when added to watchlist successfully',
    (WidgetTester tester) async {
      when(mockTvDetailBloc.state).thenReturn(
        TvDetailHasData(
          tv: testTvDetail,
          recommendations: const [],
        ),
      );
      when(mockTvDetailActionBloc.state)
          .thenReturn(TvDetailActionStatusChanged(false));

      when(mockTvDetailActionBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          TvDetailActionMessage(TvDetailActionBloc.watchlistAddSuccessMessage),
          TvDetailActionStatusChanged(true),
        ]),
      );

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
      await tester.pump(); // biar Stream jalan

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(TvDetailActionBloc.watchlistAddSuccessMessage),
          findsOneWidget);
    },
  );

  testWidgets(
    'Should show AlertDialog when failed to add to watchlist',
    (WidgetTester tester) async {
      when(mockTvDetailBloc.state).thenReturn(
        TvDetailHasData(
          tv: testTvDetail,
          recommendations: const [],
        ),
      );
      when(mockTvDetailActionBloc.state)
          .thenReturn(TvDetailActionStatusChanged(false));

      when(mockTvDetailActionBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          TvDetailActionError('Failed'),
          TvDetailActionStatusChanged(false),
        ]),
      );

      await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
      await tester.pump(); // biar Stream jalan

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
