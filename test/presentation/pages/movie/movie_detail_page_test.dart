import 'package:ditonton/presentation/pages/movie_detail/movie_detail_page.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_action/movie_detail_action_state.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_detail_bloc/movie_detail_bloc/movie_detail_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc, MovieDetailActionBloc])
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieDetailActionBloc mockMovieDetailActionBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieDetailActionBloc = MockMovieDetailActionBloc();
    when(mockMovieDetailBloc.stream).thenAnswer((_) => const Stream.empty());
    when(mockMovieDetailActionBloc.stream)
        .thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>.value(value: mockMovieDetailBloc),
        BlocProvider<MovieDetailActionBloc>.value(
            value: mockMovieDetailActionBloc),
      ],
      child: MaterialApp(home: body),
    );
  }

  testWidgets(
    'Watchlist button should display add icon when not added to watchlist',
    (WidgetTester tester) async {
      when(mockMovieDetailBloc.state).thenReturn(
        MovieDetailHasData(
          movie: testMovieDetail,
          recommendations: const [],
        ),
      );
      when(mockMovieDetailActionBloc.state)
          .thenReturn(MovieWatchlistStatusChanged(false));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);
    },
  );

  testWidgets(
    'Watchlist button should display check icon when added to watchlist',
    (WidgetTester tester) async {
      when(mockMovieDetailBloc.state).thenReturn(
        MovieDetailHasData(
          movie: testMovieDetail,
          recommendations: const [],
        ),
      );
      when(mockMovieDetailActionBloc.state)
          .thenReturn(MovieWatchlistStatusChanged(true));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);
    },
  );

  testWidgets(
    'Should show SnackBar when added to watchlist successfully',
    (WidgetTester tester) async {
      when(mockMovieDetailBloc.state).thenReturn(
        MovieDetailHasData(
          movie: testMovieDetail,
          recommendations: const [],
        ),
      );

      when(mockMovieDetailActionBloc.state)
          .thenReturn(MovieWatchlistStatusChanged(false));

      when(mockMovieDetailActionBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          MovieDetailActionMessage(
              MovieDetailActionBloc.watchlistAddSuccessMessage),
          MovieWatchlistStatusChanged(true),
        ]),
      );

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(MovieDetailActionBloc.watchlistAddSuccessMessage),
          findsOneWidget);
    },
  );

  testWidgets(
    'Should show AlertDialog when failed to add to watchlist',
    (WidgetTester tester) async {
      when(mockMovieDetailBloc.state).thenReturn(
        MovieDetailHasData(
          movie: testMovieDetail,
          recommendations: const [],
        ),
      );

      when(mockMovieDetailActionBloc.state)
          .thenReturn(MovieWatchlistStatusChanged(false));

      when(mockMovieDetailActionBloc.stream).thenAnswer(
        (_) => Stream.fromIterable([
          MovieDetailActionError('Failed'),
          MovieWatchlistStatusChanged(false),
        ]),
      );

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
      await tester.pump(); // biar Stream jalan

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    },
  );
}
