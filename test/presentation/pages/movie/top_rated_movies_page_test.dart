import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_top_rated_movies/movie_get_top_rated_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_top_rated_movies/movie_get_top_rated_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_page_test.mocks.dart';

@GenerateMocks([MovieGetTopRatedBloc])
void main() {
  late MockMovieGetTopRatedBloc mockMovieGetTopRatedBloc;

  setUp(() {
    mockMovieGetTopRatedBloc = MockMovieGetTopRatedBloc();
    // Stream kosong supaya tidak error
    when(mockMovieGetTopRatedBloc.stream)
        .thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieGetTopRatedBloc>.value(
      value: mockMovieGetTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(mockMovieGetTopRatedBloc.state).thenReturn(MovieGetTopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    when(mockMovieGetTopRatedBloc.state)
        .thenReturn(MovieGetTopRatedHasData([testMovie]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (tester) async {
    when(mockMovieGetTopRatedBloc.state)
        .thenReturn(const MovieGetTopRatedError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });
}
