import 'package:equatable/equatable.dart';
import 'genre.dart';
import 'season.dart';

class TvDetail extends Equatable {
  final int id;
  final String name;
  final String originalName;
  final String overview;
  final String posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final List<Genre> genres;
  final List<Season> seasons;
  final String firstAirDate;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String status;
  final String tagline;

  TvDetail({
    required this.id,
    required this.name,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.genres,
    required this.seasons,
    required this.firstAirDate,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.status,
    required this.tagline,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        originalName,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        genres,
        seasons,
        firstAirDate,
        numberOfEpisodes,
        numberOfSeasons,
        status,
        tagline,
      ];
}
