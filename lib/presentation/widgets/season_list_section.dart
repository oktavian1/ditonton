import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/domain/entities/tv/season.dart';
import 'package:ditonton/presentation/widgets/expandable_text.dart';

class SeasonListSection extends StatelessWidget {
  final List<Season> seasons;

  const SeasonListSection({Key? key, required this.seasons}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Seasons',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white)),
        const SizedBox(height: 8),
        if (seasons.isNotEmpty)
          ...seasons.map((s) => Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: _buildPosterImage(s.posterPath),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(s.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(
                            '${s.episodeCount} episodes | ${s.airDate}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.white70),
                          ),
                          s.overview.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: ExpandableText(text: s.overview),
                                )
                              : const Text(
                                  'No overview available.',
                                  style: TextStyle(color: Colors.white),
                                ),
                          const SizedBox(height: 4),
                          Text(
                            'Season ${s.seasonNumber} • ⭐ ${s.voteAverage}',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white54,
                                      fontStyle: FontStyle.italic,
                                    ),
                          ),
                          // if (s.episodeCount > 0)
                          //   FilledButton(
                          //     onPressed: () {
                          //       // Aksi ketika "Check Episodes" ditekan
                          //     },
                          //     child: Row(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       mainAxisSize: MainAxisSize.max,
                          //       children: [
                          //         Text(
                          //           'Check Episodes',
                          //         )
                          //       ],
                          //     ),
                          //   ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
        else
          const Text('No season data.', style: TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildPosterImage(String? path) {
//    const BASE_IMAGE_URL = 'https://image.tmdb.org/t/p/w500';
    const BASE_THUMBNAIL_URL = 'https://image.tmdb.org/t/p/w92';
    if (path == null || path.isEmpty) {
      return Image.asset(
        'assets/no_image.png',
        width: 120,
        height: 100,
        fit: BoxFit.cover,
      );
    }

    return CachedNetworkImage(
      imageUrl: '$BASE_THUMBNAIL_URL$path',
      width: 110,
      height: 150,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Image.asset(
        'assets/no_image.png',
        width: 120,
        height: 150,
        fit: BoxFit.cover,
      ),
    );
  }
}
