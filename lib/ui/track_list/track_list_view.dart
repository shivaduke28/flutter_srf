import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../application/tracks/tracks_notifier.dart';
import '../../application/library/library_manager.dart';
import 'track_list_item_view.dart';

class TrackListView extends ConsumerWidget {
  const TrackListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // stateを監視して変更があったら再ビルド
    ref.watch(tracksControllerProvider);
    final controller = ref.read(tracksControllerProvider.notifier);
    final tracks = controller.filteredAndSortedTracks;

    if (tracks.isEmpty) {
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
              '楽曲がありません',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                await ref
                    .read(libraryManagerProvider.notifier)
                    .scanLibrary(forceRefresh: true);
              },
              icon: const Icon(Icons.refresh),
              label: const Text('ライブラリを再スキャン'),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(libraryManagerProvider.notifier)
            .scanLibrary(forceRefresh: true);
      },
      child: ListView.builder(
        itemCount: tracks.length,
        itemBuilder: (context, index) {
          final track = tracks[index];
          return TrackListItemView(container: track);
        },
      ),
    );
  }
}
