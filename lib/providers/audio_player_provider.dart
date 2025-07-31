import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_srf/models/player_state.dart' as app_player;
import 'package:flutter_srf/models/srf_container.dart';
import 'package:flutter_srf/services/audio_player_service.dart';
import 'package:just_audio/just_audio.dart';

part 'audio_player_provider.g.dart';

@Riverpod(keepAlive: true)
AudioPlayerService audioPlayerService(Ref ref) {
  final service = AudioPlayerService();
  ref.onDispose(() => service.dispose());
  return service;
}

@Riverpod(keepAlive: true)
class PlayerState extends _$PlayerState {
  late final AudioPlayerService _playerService;

  @override
  app_player.PlayerState build() {
    _playerService = ref.watch(audioPlayerServiceProvider);
    _setupListeners();
    return const app_player.PlayerState();
  }

  void _setupListeners() {
    _playerService.player.playerStateStream.listen((playerState) {
      final processingState = playerState.processingState;
      if (playerState.playing) {
        state = state.copyWith(status: app_player.PlayerStatus.playing);
      } else if (processingState == ProcessingState.completed ||
          processingState == ProcessingState.idle) {
        state = state.copyWith(status: app_player.PlayerStatus.stopped);
      } else {
        state = state.copyWith(status: app_player.PlayerStatus.paused);
      }
    });

    _playerService.player.positionStream.listen((position) {
      state = state.copyWith(position: position);
    });

    _playerService.player.durationStream.listen((duration) {
      if (duration != null) {
        state = state.copyWith(duration: duration);
      }
    });
  }

  Future<void> play(SrfContainer container) async {
    try {
      await _playerService.play(container);
      state = state.copyWith(currentContainer: container);
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> pause() async {
    await _playerService.pause();
  }

  Future<void> resume() async {
    await _playerService.resume();
  }

  Future<void> stop() async {
    await _playerService.stop();
    state = state.copyWith(
      currentContainer: null,
      position: Duration.zero,
      duration: Duration.zero,
    );
  }

  Future<void> seek(Duration position) async {
    await _playerService.seek(position);
  }

  Future<void> togglePlayPause() async {
    if (state.status == app_player.PlayerStatus.playing) {
      await pause();
    } else if (state.status == app_player.PlayerStatus.paused &&
        state.currentContainer != null) {
      await resume();
    }
  }
}
