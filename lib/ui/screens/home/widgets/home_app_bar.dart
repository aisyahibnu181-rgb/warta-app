import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../widgets/theme_toggle_button.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      toolbarHeight: 100,
      backgroundColor: colors.primary,
      foregroundColor: colors.onPrimary,
      surfaceTintColor: Colors.transparent,
      elevation: 0,

      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormatter.today(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: colors.onPrimary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'BERITAKITA',
            style: theme.textTheme.headlineMedium?.copyWith(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
              color: colors.onPrimary,
            ),
          ),
        ],
      ),

      actions: const [ThemeToggleButton(), SizedBox(width: 8)],
    );
  }
}
