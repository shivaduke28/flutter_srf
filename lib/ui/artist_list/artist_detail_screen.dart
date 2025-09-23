import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../application/artists/artist.dart';
import '../../application/player/audio_player_controller.dart';
import '../../application/player/audio_player_state.dart';
import '../../application/tracks/track.dart';

class ArtistDetailScreen extends ConsumerWidget {
  final Artist artist;

  const ArtistDetailScreen({super.key, required this.artist});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(audioPlayerControllerProvider);
    final currentContainer = playerState.currentContainer;

    // アルバムごとにトラックをグループ化
    final albumGroups = <String, List<Track>>{};
    // TODO: Load tracks from repository and group by album
    // for (final track in tracks) {
    //   final albumName = track.album ?? 'Unknown Album';
    //   albumGroups.putIfAbsent(albumName, () => []).add(track);
    // }

    // アルバム名でソート
    final sortedAlbumNames = albumGroups.keys.toList()..sort();

    return Scaffold(
      appBar: AppBar(title: Text(artist.name)),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                    child: Icon(Icons.person, size: 64, color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(artist.name, style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 8),
                        Text(
                          '${artist.albumIds.length}枚のアルバム • ${artist.trackIds.length}曲',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: Divider()),
          ...sortedAlbumNames.map((albumName) {
            final tracks = albumGroups[albumName]!;

            return SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.album, color: Theme.of(context).colorScheme.secondary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(albumName, style: Theme.of(context).textTheme.titleMedium),
                              // TODO: Add year support
                              // if (firstTrack.year != null)
                              //   Text(
                              //     '${firstTrack.year}',
                              //     style: Theme.of(context).textTheme.bodySmall,
                              //   ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final track = tracks[index];
                    final isPlaying =
                        currentContainer?.filePath == track.filePath && playerState.status == PlayerStatus.playing;
                    final isPaused =
                        currentContainer?.filePath == track.filePath && playerState.status == PlayerStatus.paused;

                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: SizedBox(
                        width: 32,
                        child: Center(child: Text('${index + 1}', style: Theme.of(context).textTheme.bodyMedium)),
                      ),
                      title: Text(
                        track.title,
                        style: TextStyle(fontWeight: isPlaying || isPaused ? FontWeight.bold : null),
                      ),
                      trailing: isPlaying || isPaused
                          ? Icon(
                              isPlaying ? Icons.volume_up : Icons.pause,
                              color: Theme.of(context).colorScheme.primary,
                            )
                          : const Icon(Icons.play_arrow),
                      selected: isPlaying || isPaused,
                      onTap: () async {
                        if (isPlaying) {
                          await ref.read(audioPlayerControllerProvider.notifier).pause();
                        } else if (isPaused) {
                          await ref.read(audioPlayerControllerProvider.notifier).resume();
                        } else {
                          await ref.read(audioPlayerControllerProvider.notifier).play(track);
                        }
                      },
                    );
                  }, childCount: tracks.length),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 16)),
              ],
            );
          }),
        ],
      ),
    );
  }
}
