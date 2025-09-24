import 'package:flutter/material.dart';
import 'package:flutter_srf/application/albums/album.dart';
import 'package:flutter_srf/application/albums/album_detail_provider.dart';
import 'package:flutter_srf/application/player/audio_player_controller.dart';
import 'package:flutter_srf/application/player/audio_player_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AlbumDetailScreen extends ConsumerWidget {
  final Album album;

  const AlbumDetailScreen({required this.album, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(audioPlayerControllerProvider);
    final currentContainer = playerState.currentContainer;
    final albumTracksAsync = ref.watch(albumTracksProvider(album));

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
            child: albumTracksAsync.when(
              data: (albumTracks) {
                return ListView.builder(
                  itemCount: albumTracks.length,
                  itemBuilder: (context, index) {
                    final track = albumTracks[index];
                    final isPlaying =
                        currentContainer?.filePath == track.filePath && playerState.status == PlayerStatus.playing;
                    final isPaused =
                        currentContainer?.filePath == track.filePath && playerState.status == PlayerStatus.paused;

                    return ListTile(
                      leading: Text('${index + 1}', style: Theme.of(context).textTheme.bodyMedium),
                      title: Text(
                        track.title,
                        style: TextStyle(fontWeight: isPlaying || isPaused ? FontWeight.bold : null),
                      ),
                      subtitle: Text(track.artist),
                      trailing: isPlaying || isPaused
                          ? Icon(
                              isPlaying ? Icons.volume_up : Icons.pause,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : const Icon(Icons.play_arrow),
                      selected: isPlaying || isPaused,
                      onTap: track.filePath.isNotEmpty
                          ? () async {
                              if (isPlaying) {
                                await ref.read(audioPlayerControllerProvider.notifier).pause();
                              } else if (isPaused) {
                                await ref.read(audioPlayerControllerProvider.notifier).resume();
                              } else {
                                await ref.read(audioPlayerControllerProvider.notifier).play(track);
                              }
                            }
                          : null,
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(child: Text('エラー: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
