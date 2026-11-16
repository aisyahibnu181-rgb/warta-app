import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/navigation_provider.dart';

class HomeSearchBar extends ConsumerWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Material(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            ref.read(navigationProvider.notifier).select(1);
          },
          child: Container(
            height: 52,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 12),
                Text(
                  'Cari berita, topik, atau tokoh',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
