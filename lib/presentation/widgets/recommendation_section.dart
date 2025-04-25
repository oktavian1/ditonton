import 'package:ditonton/presentation/pages/tv_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/presentation/provider/tv_provider/tv_detail_notifier.dart';

class RecommendationSection extends StatelessWidget {
  const RecommendationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recommendations',
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: Colors.white)),
        const SizedBox(height: 8),
        Consumer<TvDetailNotifier>(
          builder: (context, notifier, child) {
            final state = notifier.tvRecomendationState;
            if (state == RequestState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state == RequestState.Error) {
              return Text(notifier.message,
                  style: const TextStyle(color: Colors.red));
            } else if (state == RequestState.Loaded) {
              return SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: notifier.tvRecomendation.length,
                  itemBuilder: (context, index) {
                    final item = notifier.tvRecomendation[index];
                    return Padding(
                      padding: const EdgeInsets.all(4),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            TvDetailPage.ROUTE_NAME,
                            arguments: item.id,
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: '$BASE_IMAGE_URL${item.posterPath}',
                            width: 100,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
