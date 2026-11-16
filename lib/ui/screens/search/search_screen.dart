
import 'package:flutter/material.dart';
import 'widgets/search_input.dart';
import 'widgets/search_results.dart';

/// Halaman Jelajahi: kolom pencarian + hasil / saran topik.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Jelajahi
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(28),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   'TEMUKAN BERITA',
                //   style: theme.textTheme.labelMedium?.copyWith(
                //     color: colors.onPrimary.withValues(alpha: 0.75),
                //     fontWeight: FontWeight.w700,
                //     letterSpacing: 1.5,
                //   ),
                // ),
                const SizedBox(height: 8),
                Text(
                  'Jelajahi',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Temukan informasi dan berita yang menarik untukmu.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.85),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 22),

                // Search bar tetap menggunakan widget lama
                const SearchInput(),
              ],
            ),
          ),

          // Area hasil pencarian dan rekomendasi
          Expanded(
            child: ColoredBox(
              color: colors.surface,
              child: const SearchResults(),
            ),
          ),
        ],
      ),
    );
  }
}
