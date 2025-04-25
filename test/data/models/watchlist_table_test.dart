import 'package:flutter_test/flutter_test.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';

void main() {
  group('WatchlistTable Tests', () {
    final tMovieDetail = MovieDetail(
      adult: false,
      backdropPath: '/backdrop.jpg',
      genres: [],
      id: 1,
      originalTitle: 'Original Title',
      overview: 'Overview',
      posterPath: '/poster.jpg',
      releaseDate: '2020-01-01',
      runtime: 120,
      title: 'Title',
      voteAverage: 8.0,
      voteCount: 100,
    );

    final tTvDetail = TvDetail(
      backdropPath: '/backdrop.jpg',
      genres: [],
      id: 2,
      originalName: 'Original Name',
      overview: 'Overview TV',
      posterPath: '/poster_tv.jpg',
      firstAirDate: '2020-01-01',
      status: 'Returning Series',
      tagline: 'Drama and more',
      voteAverage: 7.5,
      voteCount: 150,
      name: 'TV Show',
      numberOfEpisodes: 10,
      numberOfSeasons: 1,
      seasons: [],
    );

    final tWatchlistFromMovie = WatchlistTable.fromMovie(tMovieDetail);
    final tWatchlistFromTv = WatchlistTable.fromTv(tTvDetail);

    test('fromMovie should convert MovieDetail to WatchlistTable correctly',
        () {
      expect(tWatchlistFromMovie.id, tMovieDetail.id);
      expect(tWatchlistFromMovie.title, tMovieDetail.title);
      expect(tWatchlistFromMovie.overview, tMovieDetail.overview);
      expect(tWatchlistFromMovie.posterPath, tMovieDetail.posterPath);
      expect(tWatchlistFromMovie.type, 'movie');
    });

    test('fromTv should convert TvDetail to WatchlistTable correctly', () {
      expect(tWatchlistFromTv.id, tTvDetail.id);
      expect(tWatchlistFromTv.title, tTvDetail.originalName);
      expect(tWatchlistFromTv.overview, tTvDetail.overview);
      expect(tWatchlistFromTv.posterPath, tTvDetail.posterPath);
      expect(tWatchlistFromTv.type, 'tv');
    });

    test('toEntity should convert WatchlistTable to Movie entity', () {
      final movieEntity = tWatchlistFromMovie.toEntity();
      expect(movieEntity, isA<Movie>());
      expect(movieEntity.title, tWatchlistFromMovie.title);
    });

    test('toTvEntity should convert WatchlistTable to Tv entity', () {
      final tvEntity = tWatchlistFromTv.toTvEntity();
      expect(tvEntity, isA<Tv>());
      expect(tvEntity.originalName, tWatchlistFromTv.title);
    });

    test('JSON conversion should work properly', () {
      final json = tWatchlistFromMovie.toJson();
      final fromJson = WatchlistTable.fromJson(json);

      expect(fromJson, tWatchlistFromMovie);
    });
  });
}
