import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../application/tracks/track.dart';
import '../../application/audio_player/audio_player_state.dart';
import '../../application/audio_player/audio_player_service.dart';

class TrackListItemView extends ConsumerWidget {
  final Track container;

  const TrackListItemView({super.key, required this.container});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = Duration(seconds: container.duration.toInt());
    final durationText =
        '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';

    final playerState = ref.watch(audioPlayerServiceProvider);
    final isCurrentSong =
        playerState.currentContainer?.filePath == container.filePath;
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
        container.title,
        overflow: TextOverflow.ellipsis,
        style: isCurrentSong
            ? TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              )
            : null,
      ),
      subtitle: Text(
        '${container.artist} • ${container.album}',
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(durationText),
      onTap: () async {
        final notifier = ref.read(audioPlayerServiceProvider.notifier);
        if (isCurrentSong) {
          await notifier.togglePlayPause();
        } else {
          await notifier.play(container);
        }
      },
    );
  }
}
