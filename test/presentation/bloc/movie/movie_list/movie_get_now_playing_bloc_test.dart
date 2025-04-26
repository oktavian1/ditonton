import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_now_playing_movies.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_now_playing_movies/movie_get_now_playing_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_now_playing_movies/movie_get_now_playing_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_now_playing_movies/movie_get_now_playing_state.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_get_now_playing_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MovieGetNowPlayingBloc movieGetNowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieGetNowPlayingBloc = MovieGetNowPlayingBloc(mockGetNowPlayingMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(movieGetNowPlayingBloc.state, MovieGetNowPlayingEmpty());
  });

  blocTest<MovieGetNowPlayingBloc, MovieGetNowPlayingState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return movieGetNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      MovieGetNowPlayingLoading(),
      MovieGetNowPlayingHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieGetNowPlayingBloc, MovieGetNowPlayingState>(
    'should emit [Loading, Error] when getting data is unsuccessful',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieGetNowPlayingBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () => [
      MovieGetNowPlayingLoading(),
      MovieGetNowPlayingError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
