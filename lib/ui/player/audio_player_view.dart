import 'package:flutter/material.dart';
import 'package:flutter_srf/application/player/audio_player_controller.dart';
import 'package:flutter_srf/application/player/audio_player_state.dart';
import 'package:flutter_srf/errors/exceptions.dart';
import 'package:flutter_srf/ui/components/error_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AudioPlayerView extends ConsumerWidget {
  const AudioPlayerView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(audioPlayerControllerProvider);
    final currentContainer = playerState.currentContainer;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, -2))],
      ),
      child: Column(
        children: [
          if (currentContainer != null)
            LinearProgressIndicator(
              value: playerState.duration.inMilliseconds > 0
                  ? playerState.position.inMilliseconds / playerState.duration.inMilliseconds
                  : 0,
              minHeight: 2,
            )
          else
            Container(height: 2, color: Theme.of(context).colorScheme.surfaceContainerHighest),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: currentContainer != null
                  ? Row(
                      children: [
                        const CircleAvatar(radius: 24, child: Icon(Icons.music_note)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                currentContainer.title,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                currentContainer.artist,
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 120,
                          child: Row(
                            children: [
                              const Icon(Icons.volume_down, size: 20),
                              Expanded(
                                child: Slider(
                                  value: playerState.volume,
                                  min: 0.0,
                                  max: 1.0,
                                  onChanged: (value) async {
                                    try {
                                      await ref.read(audioPlayerControllerProvider.notifier).setVolume(value);
                                    } on AppException catch (e) {
                                      if (context.mounted) {
                                        showErrorSnackBar(context, e);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            playerState.status == PlayerStatus.playing ? Icons.pause : Icons.play_arrow,
                            size: 32,
                          ),
                          onPressed: () async {
                            try {
                              await ref.read(audioPlayerControllerProvider.notifier).togglePlayPause();
                            } on AppException catch (e) {
                              if (context.mounted) {
                                showErrorSnackBar(context, e);
                              }
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.stop),
                          onPressed: () async {
                            try {
                              await ref.read(audioPlayerControllerProvider.notifier).stop();
                            } on AppException catch (e) {
                              if (context.mounted) {
                                showErrorSnackBar(context, e);
                              }
                            }
                          },
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.music_off, size: 24, color: Theme.of(context).colorScheme.outline),
                        const SizedBox(width: 12),
                        Text(
                          '楽曲を選択してください',
                          style: TextStyle(color: Theme.of(context).colorScheme.outline, fontSize: 16),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
