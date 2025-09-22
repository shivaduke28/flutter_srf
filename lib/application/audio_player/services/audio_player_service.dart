import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:just_audio/just_audio.dart';
import '../../library/models/track.dart';
import '../models/audio_player_state.dart';
import 'package:path/path.dart' as path;

part 'audio_player_service.g.dart';

enum AudioProcessingState { idle, loading, ready, completed }

@Riverpod(keepAlive: true)
class AudioPlayerService extends _$AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final _currentContainerController = StreamController<Track?>.broadcast();

  @override
  AudioPlayerState build() {
    _setupListeners();
    ref.onDispose(() => dispose());
    return AudioPlayerState(
      volume: _audioPlayer.volume,
      currentContainer: null,
    );
  }

  void _setupListeners() {
    // currentContainerの監視
    _currentContainerController.stream.listen((container) {
      state = state.copyWith(currentContainer: container);
    });

    // 再生状態の監視
    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.playing) {
        state = state.copyWith(status: PlayerStatus.playing);
      } else if (state.status == PlayerStatus.playing) {
        state = state.copyWith(status: PlayerStatus.paused);
      }

      // 処理状態の監視
      final processingState = _mapProcessingState(playerState.processingState);
      if (processingState == AudioProcessingState.completed ||
          processingState == AudioProcessingState.idle) {
        state = state.copyWith(status: PlayerStatus.stopped);
      }
    });

    // positionの監視
    _audioPlayer.positionStream.listen((position) {
      state = state.copyWith(position: position);
    });

    // durationの監視
    _audioPlayer.durationStream.listen((duration) {
      if (duration != null) {
        state = state.copyWith(duration: duration);
      }
    });

    // volumeの監視
    _audioPlayer.volumeStream.listen((volume) {
      state = state.copyWith(volume: volume);
    });
  }

  Future<void> play(Track container) async {
    final audioFile = container.audioFiles.firstOrNull;
    if (audioFile == null) {
      throw Exception('No audio file found in container');
    }

    _currentContainerController.add(container);

    final audioPath = path.join(container.path, audioFile);
    await _audioPlayer.setFilePath(audioPath);
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> resume() async {
    await _audioPlayer.play();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    _currentContainerController.add(null);
    state = state.copyWith(
      position: Duration.zero,
      duration: Duration.zero,
      status: PlayerStatus.stopped,
    );
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> togglePlayPause() async {
    if (state.status == PlayerStatus.playing) {
      await pause();
    } else if (state.status == PlayerStatus.paused &&
        state.currentContainer != null) {
      await resume();
    }
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  void dispose() {
    _audioPlayer.dispose();
    _currentContainerController.close();
  }

  // Private helper methods
  static AudioProcessingState _mapProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
      case ProcessingState.buffering:
        return AudioProcessingState.loading;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
    }
  }
}
