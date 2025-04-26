import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movies_page_test.mocks.dart';

@GenerateMocks([MovieGetPopularBloc])
void main() {
  late MockMovieGetPopularBloc mockMovieGetPopularBloc;

  setUp(() {
    mockMovieGetPopularBloc = MockMovieGetPopularBloc();
    // Stub stream kosong supaya tidak error
    when(mockMovieGetPopularBloc.stream)
        .thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieGetPopularBloc>.value(
      value: mockMovieGetPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(mockMovieGetPopularBloc.state).thenReturn(MoviePopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    when(mockMovieGetPopularBloc.state)
        .thenReturn(MoviePopularHasData([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error',
      (tester) async {
    when(mockMovieGetPopularBloc.state)
        .thenReturn(const MoviePopularError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });
}
