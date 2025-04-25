import 'package:flutter/material.dart';
import 'package:ditonton/presentation/widgets/expandable_text.dart';

class OverviewSection extends StatelessWidget {
  final String overview;

  const OverviewSection({Key? key, required this.overview}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hasOverview = overview.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 4),
        hasOverview
            ? ExpandableText(text: overview)
            : const Text(
                'No overview available.',
                style: TextStyle(color: Colors.white70),
              ),
      ],
    );
  }
}
