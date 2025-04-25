import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';

class WatchlistTable extends Equatable {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String type;

  const WatchlistTable({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.type,
  });

  factory WatchlistTable.fromJson(Map<String, dynamic> json) => WatchlistTable(
        id: json['id'],
        title: json['title'],
        overview: json['overview'],
        posterPath: json['posterPath'],
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'overview': overview,
        'posterPath': posterPath,
        'type': type,
      };

  factory WatchlistTable.fromMovie(MovieDetail movie) => WatchlistTable(
        id: movie.id,
        title: movie.title,
        overview: movie.overview,
        posterPath: movie.posterPath,
        type: 'movie',
      );

  factory WatchlistTable.fromTv(TvDetail tv) => WatchlistTable(
        id: tv.id,
        title: tv.originalName,
        overview: tv.overview,
        posterPath: tv.posterPath,
        type: 'tv',
      );
  Movie toEntity() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
      );

  Tv toTvEntity() => Tv.watchlist(
        id: id,
        originalName: title,
        overview: overview,
        posterPath: posterPath,
      );

  @override
  List<Object?> get props => [id, title, overview, posterPath, type];
}
