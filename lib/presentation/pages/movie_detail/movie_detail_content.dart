import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/presentation/pages/movie_detail/recommendation_list.dart';
import 'package:ditonton/presentation/pages/movie_detail/watchlist_button.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/domain/entities/movie/movie.dart';
import 'package:ditonton/domain/entities/movie/movie_detail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ditonton/common/constants.dart';

class MovieDetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const MovieDetailContent({
    required this.movie,
    required this.recommendations,
    required this.isAddedWatchlist,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 56),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title, style: kHeading5),
                      const SizedBox(height: 8),
                      WatchlistButton(
                          movie: movie, isAddedWatchlist: isAddedWatchlist),
                      const SizedBox(height: 8),
                      Text(_showGenres(movie.genres)),
                      Text(_showDuration(movie.runtime)),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: movie.voteAverage / 2,
                            itemCount: 5,
                            itemBuilder: (context, _) =>
                                const Icon(Icons.star, color: kMikadoYellow),
                            itemSize: 24,
                          ),
                          Text(' ${movie.voteAverage}')
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('Overview', style: kHeading6),
                      Text(movie.overview),
                      const SizedBox(height: 16),
                      Text('Recommendations', style: kHeading6),
                      RecommendationList(recommendations: recommendations),
                    ],
                  ),
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List genres) => genres.map((e) => e.name).join(', ');

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;
    return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
  }
}
