import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/movie/genre.dart';
import 'package:ditonton/domain/entities/tv/genre.dart' as genre;
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testTv = Tv(
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalName: 'Spider-Man: The Series',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  firstAirDate: '2002-05-01',
  voteAverage: 7.2,
  voteCount: 13507,
);
final testTvList = [testTv];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testTvDetail = TvDetail(
  id: 1,
  name: 'TV Title',
  originalName: 'Original TV Title',
  overview: 'TV show overview here.',
  posterPath: '/posterPath.jpg',
  backdropPath: 'backdropPath',
  voteAverage: 8.5,
  voteCount: 100,
  genres: [genre.Genre(id: 1, name: 'Drama')],
  seasons: [],
  firstAirDate: '2023-01-01',
  numberOfEpisodes: 10,
  numberOfSeasons: 1,
  status: 'Ended',
  tagline: 'TV tagline',
);

final testWatchlistTv = WatchlistTable(
  id: 1,
  title: 'Original TV Title',
  overview: 'TV show overview here.',
  posterPath: '/posterPath.jpg',
  type: 'tv',
);

final testWatchlistTvTesRemove = Tv.watchlist(
    id: 1,
    originalName: 'title',
    posterPath: 'posterPath',
    overview: 'overview');

final testWatchlistTv2 = WatchlistTable(
  id: 2,
  title: 'Original TV Title 2',
  overview: 'TV show overview here. 2',
  posterPath: '/posterPath.jpg 2',
  type: 'tv',
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testWatchlistMovie2 = Movie.watchlist(
  id: 2,
  title: 'title 2',
  posterPath: 'posterPath 2',
  overview: 'overview 2',
);

final testMovieTable = WatchlistTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'movie',
);

final testTvTable = WatchlistTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'tv',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 'movie',
};

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 'tv',
};
