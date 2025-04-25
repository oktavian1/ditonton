import 'package:ditonton/data/models/tv/detail_model/created_by_model.dart';
import 'package:ditonton/data/models/tv/detail_model/last_episode_model.dart';
import 'package:ditonton/data/models/tv/detail_model/network_model.dart';
import 'package:ditonton/data/models/tv/detail_model/production_company_model.dart';
import 'package:ditonton/data/models/tv/detail_model/production_country_model.dart';
import 'package:ditonton/data/models/tv/detail_model/season_model.dart';
import 'package:ditonton/data/models/tv/detail_model/spoken_language_model.dart';
import 'package:ditonton/domain/entities/tv/genre.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:equatable/equatable.dart';
import '../../../../domain/entities/tv/season.dart';
import 'genre_model.dart';

class TvDetailResponse extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<CreatedByModel> createdBy;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String lastAirDate;
  final LastEpisodeModel? lastEpisodeToAir;
  final String name;
  final dynamic nextEpisodeToAir;
  final List<NetworkModel> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompanyModel> productionCompanies;
  final List<ProductionCountryModel> productionCountries;
  final List<SeasonModel> seasons;
  final List<SpokenLanguageModel> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  const TvDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.createdBy,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.lastEpisodeToAir,
    required this.name,
    required this.nextEpisodeToAir,
    required this.networks,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.seasons,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvDetailResponse.fromJson(Map<String, dynamic> json) =>
      TvDetailResponse(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        createdBy: List<CreatedByModel>.from(
          json["created_by"].map(
            (x) => CreatedByModel.fromJson(x),
          ),
        ),
        episodeRunTime: List<int>.from(json["episode_run_time"]),
        firstAirDate: json["first_air_date"],
        genres: List<GenreModel>.from(
          json["genres"].map(
            (x) => GenreModel.fromJson(x),
          ),
        ),
        homepage: json["homepage"],
        id: json["id"],
        inProduction: json["in_production"],
        languages: List<String>.from(json["languages"]),
        lastAirDate: json["last_air_date"],
        lastEpisodeToAir: json["last_episode_to_air"] != null
            ? LastEpisodeModel.fromJson(json["last_episode_to_air"])
            : null,
        name: json["name"],
        nextEpisodeToAir: json["next_episode_to_air"],
        networks: List<NetworkModel>.from(
          json["networks"].map(
            (x) => NetworkModel.fromJson(x),
          ),
        ),
        numberOfEpisodes: json["number_of_episodes"],
        numberOfSeasons: json["number_of_seasons"],
        originCountry: List<String>.from(json["origin_country"]),
        originalLanguage: json["original_language"],
        originalName: json["original_name"],
        overview: json["overview"],
        popularity: (json["popularity"] ?? 0).toDouble(),
        posterPath: json["poster_path"],
        productionCompanies: List<ProductionCompanyModel>.from(
          json["production_companies"].map(
            (x) => ProductionCompanyModel.fromJson(x),
          ),
        ),
        productionCountries: List<ProductionCountryModel>.from(
          json["production_countries"].map(
            (x) => ProductionCountryModel.fromJson(x),
          ),
        ),
        seasons: List<SeasonModel>.from(
          json["seasons"].map(
            (x) => SeasonModel.fromJson(x),
          ),
        ),
        spokenLanguages: List<SpokenLanguageModel>.from(
          json["spoken_languages"].map(
            (x) => SpokenLanguageModel.fromJson(x),
          ),
        ),
        status: json["status"],
        tagline: json["tagline"],
        type: json["type"],
        voteAverage: (json["vote_average"] ?? 0).toDouble(),
        voteCount: json["vote_count"],
      );

  TvDetail toEntity() {
    return TvDetail(
      id: id,
      name: name,
      originalName: originalName,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      genres: genres.map((g) => Genre(id: g.id, name: g.name)).toList(),
      seasons: seasons.map((s) {
        final safePosterPath = s.posterPath ?? '';
        final safeName = s.name;
        final safeOverview = s.overview;
        final safeAirDate = s.airDate;

        print('Season ID: ${s.id}');
        print('PosterPath: $safePosterPath');
        print('Name: $safeName');
        print('AirDate: $safeAirDate');

        return Season(
          id: s.id,
          name: safeName,
          overview: safeOverview,
          posterPath: safePosterPath,
          seasonNumber: s.seasonNumber,
          episodeCount: s.episodeCount,
          voteAverage: s.voteAverage,
          airDate: safeAirDate ?? '',
        );
      }).toList(),
      firstAirDate: firstAirDate,
      numberOfEpisodes: numberOfEpisodes,
      numberOfSeasons: numberOfSeasons,
      status: status,
      tagline: tagline,
    );
  }

  @override
  List<Object?> get props => [id, name];

  @override
  String toString() {
    return 'TvDetailResponse(id: $id, name: $name, season: ${seasons.map((g) => g.posterPath).join(', ')} , genres: ${genres.map((g) => g.name).join(', ')}, seasons: ${seasons.length}, overview: ${overview.substring(0, overview.length > 30 ? 30 : overview.length)}...)';
  }
}
