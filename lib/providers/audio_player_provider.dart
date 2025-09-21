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
    return app_player.PlayerState(volume: _playerService.volume);
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
      // まず先にcurrentContainerを更新
      state = state.copyWith(
        currentContainer: container,
        position: Duration.zero,
      );

      await _playerService.play(container);

      // durationが取得できるまで少し待つ
      final duration = _playerService.player.duration ?? Duration.zero;

      // durationとstatusを更新
      state = state.copyWith(
        duration: duration,
        status: app_player.PlayerStatus.playing,
      );
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
      status: app_player.PlayerStatus.stopped,
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

  Future<void> setVolume(double volume) async {
    await _playerService.setVolume(volume);
    state = state.copyWith(volume: volume);
  }
}
