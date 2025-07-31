import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/srf_container.dart';
import '../models/player_state.dart';
import '../providers/audio_player_provider.dart';

class SongListTile extends ConsumerWidget {
  final SrfContainer container;

  const SongListTile({super.key, required this.container});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metadata = container.metadata;
    final duration = Duration(seconds: metadata.duration.toInt());
    final durationText =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    final playerState = ref.watch(playerStateProvider);
    final isCurrentSong = playerState.currentContainer?.path == container.path;
    final isPlaying =
        isCurrentSong && playerState.status == PlayerStatus.playing;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isCurrentSong ? Theme.of(context).primaryColor : null,
        child: Icon(
          isPlaying ? Icons.pause : Icons.music_note,
          color: isCurrentSong ? Colors.white : null,
        ),
      ),
      title: Text(
        metadata.title,
        overflow: TextOverflow.ellipsis,
        style: isCurrentSong
            ? TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              )
            : null,
      ),
      subtitle: Text(
        '${metadata.artist} ${metadata.album != null ? '• ${metadata.album}' : ''}',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(durationText),
          IconButton(
            icon: Icon(
              isPlaying ? Icons.pause_circle : Icons.play_circle,
              color: isCurrentSong ? Theme.of(context).primaryColor : null,
            ),
            onPressed: () async {
              final notifier = ref.read(playerStateProvider.notifier);
              if (isCurrentSong) {
                await notifier.togglePlayPause();
              } else {
                await notifier.play(container);
              }
            },
          ),
        ],
      ),
      onTap: () async {
        final notifier = ref.read(playerStateProvider.notifier);
        if (isCurrentSong) {
          await notifier.togglePlayPause();
        } else {
          await notifier.play(container);
        }
      },
    );
  }
}
