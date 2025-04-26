import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/usecases/movie_usecase/get_popular_movies.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_bloc.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_event.dart';
import 'package:ditonton/presentation/provider/movie_provider/movie_list_bloc/get_popular_movies/movie_get_popular_state.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'movie_get_popular_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MovieGetPopularBloc movieGetPopularBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    movieGetPopularBloc = MovieGetPopularBloc(mockGetPopularMovies);
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
    expect(movieGetPopularBloc.state, MoviePopularEmpty());
  });

  blocTest<MovieGetPopularBloc, MovieGetPopularState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return movieGetPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MovieGetPopularBloc, MovieGetPopularState>(
    'should emit [Loading, Error] when getting data is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieGetPopularBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () => [
      MoviePopularLoading(),
      MoviePopularError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
