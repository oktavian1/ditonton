import 'dart:convert';

import 'package:ditonton/data/models/tv/tv_model.dart';
import 'package:ditonton/data/models/tv/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
    genreIds: [9648, 18],
    id: 202250,
    originalName: "Dirty Linen",
    overview:
        "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
    popularity: 2797.914,
    posterPath: "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
    firstAirDate: "2023-01-23",
    voteAverage: 5,
    voteCount: 13,
  );

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/popular_tv.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // act
      final result = tTvResponseModel.toJson();

      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/mAJ84W6I8I272Da87qplS2Dp9ST.jpg",
            "genre_ids": [9648, 18],
            "id": 202250,
            "original_name": "Dirty Linen",
            "overview":
                "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
            "popularity": 2797.914,
            "poster_path": "/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg",
            "first_air_date": "2023-01-23",
            "vote_average": 5.0,
            "vote_count": 13,
          }
        ]
      };
      expect(result, expectedJsonMap);
    });
  });
}
