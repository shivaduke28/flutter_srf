import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../application/library/providers/tracks_provider.dart';
import '../../../application/tracks/track_sort_type_provider.dart';
import '../../../application/tracks/track_query_provider.dart';
import 'track_list_item_view.dart';

class TrackListView extends ConsumerWidget {
  const TrackListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final containersAsync = ref.watch(tracksProvider);
    final sortType = ref.watch(trackSortTypeNotifierProvider);
    final query = ref.watch(trackQueryNotifierProvider);

    return containersAsync.when(
      data: (containers) {
        final notifier = ref.read(tracksProvider.notifier);

        // 検索フィルタリング
        var filteredContainers = query.isEmpty
            ? containers
            : notifier.searchTracks(query);

        // ソート
        filteredContainers = notifier.sortTracks(
          filteredContainers,
          sortType == TrackSortType.title
              ? SortType.title
              : sortType == TrackSortType.artist
              ? SortType.artist
              : SortType.dateAdded,
        );

        if (filteredContainers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.music_note,
                  size: 64,
                  color: Theme.of(context).colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  query.isEmpty ? '楽曲がありません' : '検索結果がありません',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(tracksProvider.notifier).refresh();
          },
          child: ListView.builder(
            itemCount: filteredContainers.length,
            itemBuilder: (context, index) {
              final container = filteredContainers[index];
              return TrackListItemView(container: container);
            },
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 16),
            Text('エラー: $error'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                ref.read(tracksProvider.notifier).refresh();
              },
              child: const Text('再読み込み'),
            ),
          ],
        ),
      ),
    );
  }
}
