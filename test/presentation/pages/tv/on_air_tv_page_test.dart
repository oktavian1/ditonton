import 'package:ditonton/presentation/pages/on_air_tv_page.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_list_bloc/tv_on_air_bloc/tv_on_air_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'on_air_tv_page_test.mocks.dart';

@GenerateMocks([TvOnAirBloc])
void main() {
  late MockTvOnAirBloc mockTvOnAirBloc;

  setUp(() {
    mockTvOnAirBloc = MockTvOnAirBloc();
    // Stub stream kosong
    when(mockTvOnAirBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TvOnAirBloc>.value(
      value: mockTvOnAirBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (tester) async {
    when(mockTvOnAirBloc.state).thenReturn(TvOnAirLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (tester) async {
    when(mockTvOnAirBloc.state).thenReturn(TvOnAirHasData([testTv]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (tester) async {
    when(mockTvOnAirBloc.state).thenReturn(const TvOnAirError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnAirTvPage()));

    expect(textFinder, findsOneWidget);
    expect(find.text('Error message'), findsOneWidget);
  });
}
