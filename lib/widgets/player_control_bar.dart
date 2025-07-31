import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/player_state.dart';
import '../providers/audio_player_provider.dart';

class PlayerControlBar extends ConsumerWidget {
  const PlayerControlBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerState = ref.watch(playerStateProvider);
    final currentContainer = playerState.currentContainer;

    if (currentContainer == null) {
      return const SizedBox.shrink();
    }

    final metadata = currentContainer.metadata;
    final isPlaying = playerState.status == PlayerStatus.playing;
    final position = playerState.position;
    final duration = playerState.duration;

    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          LinearProgressIndicator(
            value: duration.inMilliseconds > 0
                ? position.inMilliseconds / duration.inMilliseconds
                : 0,
            minHeight: 2,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(radius: 24, child: Icon(Icons.music_note)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          metadata.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          metadata.artist,
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
                            onChanged: (value) {
                              ref
                                  .read(playerStateProvider.notifier)
                                  .setVolume(value);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 32,
                    ),
                    onPressed: () {
                      ref.read(playerStateProvider.notifier).togglePlayPause();
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.stop),
                    onPressed: () {
                      ref.read(playerStateProvider.notifier).stop();
                    },
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
