class SeasonModel {
  final String? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final double voteAverage;

  SeasonModel({
    this.airDate = '',
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.overview,
    this.posterPath,
    required this.seasonNumber,
    required this.voteAverage,
  });

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        airDate: json['air_date'] ?? '',
        episodeCount: json['episode_count'],
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        posterPath: json['poster_path'] ?? '',
        seasonNumber: json['season_number'],
        voteAverage: (json['vote_average'] ?? 0).toDouble(),
      );
}
