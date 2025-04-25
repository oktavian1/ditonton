import 'package:ditonton/presentation/provider/tv_provider/tv_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/overview_section.dart';
import 'package:ditonton/presentation/widgets/recommendation_section.dart';
import 'package:ditonton/presentation/widgets/season_list_section.dart';
import 'package:flutter/material.dart';
import 'package:ditonton/domain/entities/tv/tv_detail.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ditonton/common/constants.dart';
import 'package:provider/provider.dart';

class TvDetailView extends StatelessWidget {
  final TvDetail tv;

  const TvDetailView({Key? key, required this.tv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
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
                      _buildWatchlistButton(context),
                      const SizedBox(height: 8),
                      OverviewSection(overview: tv.overview),
                      const SizedBox(height: 16),
                      RecommendationSection(),
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
          Text(tv.name,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          Text(
            tv.genres.map((g) => g.name).join(', '),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white70),
          ),
          Text('${tv.numberOfEpisodes} episodes',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white70)),
        ],
      );

  Widget _buildRating(BuildContext context) => Row(
        children: [
          RatingBarIndicator(
            rating: tv.voteAverage / 2,
            itemCount: 5,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: 24,
          ),
          const SizedBox(width: 8),
          Text('${tv.voteAverage}',
              style: const TextStyle(color: Colors.white)),
        ],
      );

  Widget _buildWatchlistButton(BuildContext context) {
    return Consumer<TvDetailNotifier>(
      builder: (context, notifier, child) {
        final isAdded = notifier.isAddedToWatchlist;

        return FilledButton(
          onPressed: () async {
            if (!isAdded) {
              await notifier.addWatchlist(notifier.tv);
            } else {
              await notifier.removeFromWatchlist(notifier.tv);
            }

            final message = notifier.watchlistMessage;

            if (message.contains('Added') || message.contains('Removed')) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text(message),
                ),
              );
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isAdded ? Icons.check : Icons.add),
              const SizedBox(width: 8),
              Text('Watchlist'),
            ],
          ),
        );
      },
    );
  }

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
