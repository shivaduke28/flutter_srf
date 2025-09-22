import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../application/albums/albums_provider.dart';
import '../../../application/audio_player/services/audio_player_service.dart';
import '../../../application/audio_player/models/audio_player_state.dart';

class AlbumDetailScreen extends ConsumerWidget {
  final AlbumInfo album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(audioPlayerServiceProvider);
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
                      await ref
                          .read(audioPlayerServiceProvider.notifier)
                          .pause();
                    } else if (isPaused) {
                      await ref
                          .read(audioPlayerServiceProvider.notifier)
                          .resume();
                    } else {
                      await ref
                          .read(audioPlayerServiceProvider.notifier)
                          .play(track);
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
