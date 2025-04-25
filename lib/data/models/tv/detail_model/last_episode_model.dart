class LastEpisodeModel {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  final String airDate;
  final int episodeNumber;
  final String productionCode;
  final int runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;

  LastEpisodeModel({
    required this.id,
    required this.name,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
    required this.airDate,
    required this.episodeNumber,
    required this.productionCode,
    this.runtime = 0,
    required this.seasonNumber,
    required this.showId,
    this.stillPath,
  });

  factory LastEpisodeModel.fromJson(Map<String, dynamic> json) =>
      LastEpisodeModel(
        id: json['id'],
        name: json['name'],
        overview: json['overview'],
        voteAverage: (json['vote_average'] ?? 0).toDouble(),
        voteCount: json['vote_count'],
        airDate: json['air_date'],
        episodeNumber: json['episode_number'],
        productionCode: json['production_code'],
        runtime: json['runtime'] ?? 0,
        seasonNumber: json['season_number'],
        showId: json['show_id'],
        stillPath: json['still_path'] ?? '',
      );
}
