import 'package:equatable/equatable.dart';

class Season extends Equatable {
  final int id;
  final String name;
  final String overview;
  final String posterPath;
  final int seasonNumber;
  final int episodeCount;
  final double voteAverage;
  final String airDate;

  Season({
    required this.id,
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.seasonNumber,
    required this.episodeCount,
    required this.voteAverage,
    required this.airDate,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        overview,
        posterPath,
        seasonNumber,
        episodeCount,
        voteAverage,
        airDate,
      ];
}
