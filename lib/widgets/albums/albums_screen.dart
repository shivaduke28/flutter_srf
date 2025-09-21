import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../providers/albums_provider.dart';
import '../../providers/audio_player_provider.dart';
import '../../models/player_state.dart';

class AlbumsScreen extends ConsumerWidget {
  const AlbumsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final albumsAsync = ref.watch(albumsListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('アルバム')),
      body: albumsAsync.when(
        data: (albums) {
          if (albums.isEmpty) {
            return const Center(child: Text('アルバムが見つかりません'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: albums.length,
            itemBuilder: (context, index) {
              final album = albums[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AlbumDetailScreen(album: album),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.album,
                              size: 64,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              album.name,
                              style: Theme.of(context).textTheme.titleMedium,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              album.artist,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${album.trackCount}曲${album.year != null ? ' • ${album.year}' : ''}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('エラーが発生しました: $error')),
      ),
    );
  }
}

class AlbumDetailScreen extends ConsumerWidget {
  final AlbumInfo album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    final currentContainer = playerState.currentContainer;

    return Scaffold(
      appBar: AppBar(title: Text(album.name)),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.album,
                    size: 64,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        album.name,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        album.artist,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${album.trackCount}曲${album.year != null ? ' • ${album.year}年' : ''}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: album.tracks.length,
              itemBuilder: (context, index) {
                final track = album.tracks[index];
                final isPlaying =
                    currentContainer?.path == track.path &&
                    playerState.status == PlayerStatus.playing;
                final isPaused =
                    currentContainer?.path == track.path &&
                    playerState.status == PlayerStatus.paused;

                return ListTile(
                  leading: Text(
                    '${track.metadata.trackNumber ?? index + 1}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  title: Text(
                    track.metadata.title,
                    style: TextStyle(
                      fontWeight: isPlaying || isPaused
                          ? FontWeight.bold
                          : null,
                    ),
                  ),
                  subtitle: Text(track.metadata.artist),
                  trailing: isPlaying || isPaused
                      ? Icon(
                          isPlaying ? Icons.volume_up : Icons.pause,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : const Icon(Icons.play_arrow),
                  selected: isPlaying || isPaused,
                  onTap: () async {
                    if (isPlaying) {
                      await ref.read(playerStateProvider.notifier).pause();
                    } else if (isPaused) {
                      await ref.read(playerStateProvider.notifier).resume();
                    } else {
                      await ref.read(playerStateProvider.notifier).play(track);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
