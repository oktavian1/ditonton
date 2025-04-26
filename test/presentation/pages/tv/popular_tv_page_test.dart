import 'package:ditonton/presentation/pages/popular_tv_page.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_popular_bloc/tv_popular_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([TvPopularBloc])
void main() {
  late MockTvPopularBloc mockTvPopularBloc;

  setUp(() {
    mockTvPopularBloc = MockTvPopularBloc();
    // Stub stream supaya tidak error
    when(mockTvPopularBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvPopularBloc>.value(
      value: mockTvPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(mockTvPopularBloc.state).thenReturn(TvPopularLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    when(mockTvPopularBloc.state).thenReturn(TvPopularHasData([testTv]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when error',
      (tester) async {
    when(mockTvPopularBloc.state)
        .thenReturn(const TvPopularError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvsPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });
}
