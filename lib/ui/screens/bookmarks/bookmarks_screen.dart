
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/bookmark_provider.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/theme_toggle_button.dart';
import 'widgets/bookmark_item.dart';

class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookmarksAsync = ref.watch(bookmarksProvider);
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return ColoredBox(
      color: colors.primary,
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            toolbarHeight: 90,
            backgroundColor: colors.primary,
            foregroundColor: colors.onPrimary,
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KOLEKSI PRIBADI',
                  style: textTheme.labelSmall?.copyWith(
                    color: colors.onPrimary.withValues(alpha: 0.75),
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Artikel Tersimpan',
                  style: textTheme.headlineSmall?.copyWith(
                    color: colors.onPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            actions: const [
              ThemeToggleButton(),
              SizedBox(width: 8),
            ],
          ),

          SliverToBoxAdapter(
            child: Container(
              height: 22,
              color: colors.primary,
            ),
          ),

          DecoratedSliver(
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 26, 20, 18),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: colors.primary.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.bookmark_rounded,
                            color: colors.primary,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bacaan Favoritmu',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Kumpulan berita yang ingin kamu baca lagi',
                                style: textTheme.bodySmall?.copyWith(
                                  color: colors.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                bookmarksAsync.when(
                  loading: () => const SliverFillRemaining(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (error, stackTrace) => SliverFillRemaining(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Gagal memuat bookmark: $error',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  data: (bookmarks) {
                    if (bookmarks.isEmpty) {
                      return const SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyState(
                          icon: Icons.bookmark_border_rounded,
                          title: 'Belum ada berita tersimpan',
                          message:
                              'Ketuk ikon bookmark pada berita\nuntuk membacanya nanti.',
                        ),
                      );
                    }

                    return SliverList.separated(
                      itemCount: bookmarks.length,
                      separatorBuilder: (_, _) => const Divider(
                        indent: 16,
                        endIndent: 16,
                      ),
                      itemBuilder: (_, index) {
                        return BookmarkItem(
                          article: bookmarks[index],
                        );
                      },
                    );
                  },
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
