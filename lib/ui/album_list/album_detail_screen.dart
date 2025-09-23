import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../application/albums/album.dart';
import '../../application/tracks/track.dart';
import '../../application/player/audio_player_controller.dart';
import '../../application/player/audio_player_state.dart';

class AlbumDetailScreen extends ConsumerWidget {
  final Album album;

  const AlbumDetailScreen({super.key, required this.album});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(audioPlayerControllerProvider);
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
                    color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.album, size: 64, color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(album.name, style: Theme.of(context).textTheme.headlineSmall),
                      const SizedBox(height: 8),
                      Text(album.artist ?? 'Unknown Artist', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        '${album.srfContainerIds.length}曲${album.year != null ? ' • ${album.year}年' : ''}',
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
              itemCount: album.srfContainerIds.length,
              itemBuilder: (context, index) {
                // TODO: Get track by index from repository
                final Track? track = null;
                final isPlaying =
                    track != null &&
                    currentContainer?.filePath == track.filePath &&
                    playerState.status == PlayerStatus.playing;
                final isPaused =
                    track != null &&
                    currentContainer?.filePath == track.filePath &&
                    playerState.status == PlayerStatus.paused;

                return ListTile(
                  leading: Text('${index + 1}', style: Theme.of(context).textTheme.bodyMedium),
                  title: Text(
                    track?.title ?? 'Unknown Track',
                    style: TextStyle(fontWeight: isPlaying || isPaused ? FontWeight.bold : null),
                  ),
                  subtitle: Text(track?.artist ?? 'Unknown Artist'),
                  trailing: isPlaying || isPaused
                      ? Icon(isPlaying ? Icons.volume_up : Icons.pause, color: Theme.of(context).colorScheme.primary)
                      : const Icon(Icons.play_arrow),
                  selected: isPlaying || isPaused,
                  onTap: () async {
                    if (isPlaying) {
                      await ref.read(audioPlayerControllerProvider.notifier).pause();
                    } else if (isPaused) {
                      await ref.read(audioPlayerControllerProvider.notifier).resume();
                    } else {
                      await ref.read(audioPlayerControllerProvider.notifier).play(track!);
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
