
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/search_provider.dart';

/// Rekomendasi topik populer pada halaman Jelajahi.
class SearchSuggestions extends ConsumerWidget {
  const SearchSuggestions({super.key});

  static const _topics = [
    'Artificial Intelligence',
    'Climate',
    'Economy',
    'Football',
    'Space',
    'Startup',
    'Health',
    'Election',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
      children: [
        Row(
          children: [
            Icon(
              Icons.trending_up_rounded,
              color: colors.primary,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              'Topik populer',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),

        const SizedBox(height: 6),

        Text(
          'Mulai jelajahi berbagai topik yang sedang menarik perhatian.',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: colors.onSurfaceVariant,
            height: 1.5,
          ),
        ),

        const SizedBox(height: 20),

        Wrap(
          spacing: 10,
          runSpacing: 12,
          children: [
            for (final topic in _topics)
              ActionChip(
                avatar: Icon(
                  Icons.trending_up_rounded,
                  size: 17,
                  color: colors.primary,
                ),
                label: Text(topic),
                labelStyle: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                backgroundColor: colors.surfaceContainerHigh,
                side: BorderSide(
                  color: colors.outlineVariant,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                onPressed: () {
                  ref.read(searchQueryProvider.notifier).submit(topic);
                },
              ),
          ],
        ),
      ],
    );
  }
}
