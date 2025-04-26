import 'package:ditonton/domain/entities/tv/tv.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_bloc.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_bloc/tv_detail_action/tv_detail_action_event.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';
import 'package:ditonton/presentation/widgets/overview_section.dart';
import 'package:ditonton/presentation/widgets/season_list_section.dart';
import 'package:ditonton/presentation/widgets/recommendation_section.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ditonton/common/constants.dart';

class TvDetailView extends StatelessWidget {
  final TvDetail tv;

  final List<Tv> recommendations;
  final bool isAddedWatchlist;
  const TvDetailView(
      {Key? key,
      required this.tv,
      required this.recommendations,
      required this.isAddedWatchlist})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
          width: screenWidth,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: kRichBlack,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: SingleChildScrollView(
                controller: scrollController,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDragHandle(),
                    const SizedBox(height: 12),
                    _buildTitleAndInfo(context),
                    const SizedBox(height: 8),
                    _buildRating(context),
                    const SizedBox(height: 8),
                    _buildWatchlistButton(context, isAddedWatchlist, tv),
                    const SizedBox(height: 8),
                    OverviewSection(overview: tv.overview),
                    const SizedBox(height: 16),
                    RecommendationSection(
                      recommendations: recommendations,
                    ),
                    const SizedBox(height: 16),
                    SeasonListSection(seasons: tv.seasons),
                  ],
                ),
              ),
            );
          },
        ),
        _buildBackButton(context),
      ],
    );
  }

  Widget _buildWatchlistButton(
      BuildContext context, bool isAdded, TvDetail tv) {
    return FilledButton(
      onPressed: () {
        if (!isAdded) {
          context.read<TvDetailActionBloc>().add(AddToWatchlist(tv));
        } else {
          context.read<TvDetailActionBloc>().add(RemoveFromWatchlist(tv));
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(isAdded ? Icons.check : Icons.add),
          const SizedBox(width: 8),
          const Text('Watchlist'),
        ],
      ),
    );
  }

  Widget _buildDragHandle() => Center(
        child: Container(
          height: 5,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );

  Widget _buildTitleAndInfo(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tv.name,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 8),
          Text(
            tv.genres.map((g) => g.name).join(', '),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
          Text(
            '${tv.numberOfEpisodes} episodes',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
        ],
      );

  Widget _buildRating(BuildContext context) => Row(
        children: [
          RatingBarIndicator(
            rating: tv.voteAverage / 2,
            itemCount: 5,
            itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.amber),
            itemSize: 24,
          ),
          const SizedBox(width: 8),
          Text('${tv.voteAverage}',
              style: const TextStyle(color: Colors.white)),
        ],
      );

  Widget _buildBackButton(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.black54,
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      );
}
