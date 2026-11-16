import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';

import 'widgets/category_chips.dart';
import 'widgets/headlines_section.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/home_search_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    final provider = headlinesProvider(ref.read(SelectedCategoryProvider));

    ref.invalidate(provider);

    try {
      await ref.read(provider.future);
    } catch (_) {
      // tidak melakukan apa-apa saat terjadi error
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: ColoredBox(
        // Warna hijau terlihat di belakang sudut panel
        color: colors.primary,
        child: CustomScrollView(
          slivers: [
            // Header hijau
            const HomeAppBar(),

            // Jarak hijau antara header dan panel putih
            const SliverToBoxAdapter(child: SizedBox(height: 16)),

            // Panel putih yang mengikuti seluruh konten saat scroll
            DecoratedSliver(
              decoration: BoxDecoration(
                color: colors.surfaceContainerLowest,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              sliver: SliverMainAxisGroup(
                slivers: [
                  // Kategori berita
                  const SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: CategoryChips(),
                    ),
                  ),

                  // Search bar
                  const SliverToBoxAdapter(child: HomeSearchBar()),

                  // Daftar berita dari API
                  const HeadlinesSection(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
