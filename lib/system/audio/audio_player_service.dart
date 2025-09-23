import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'audio_player_service.g.dart';

/// プレイヤーの処理状態
enum AudioProcessingState { idle, loading, ready, completed }

/// プレイヤーの再生状態
enum PlaybackStatus { playing, paused, stopped }

/// 音楽再生のための低レベルサービス
/// just_audioへの依存をここで隠蔽
@riverpod
AudioPlayerService audioPlayerService(Ref ref) {
  final service = AudioPlayerService();
  ref.onDispose(() => service.dispose());
  return service;
}

class AudioPlayerService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Streams for external listening
  Stream<PlaybackStatus> get statusStream =>
      _audioPlayer.playerStateStream.map((state) {
        if (state.playing) {
          return PlaybackStatus.playing;
        } else if (state.processingState == ProcessingState.idle ||
            state.processingState == ProcessingState.completed) {
          return PlaybackStatus.stopped;
        } else {
          return PlaybackStatus.paused;
        }
      });

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  Stream<double> get volumeStream => _audioPlayer.volumeStream;

  Stream<AudioProcessingState> get processingStateStream => _audioPlayer
      .playerStateStream
      .map((state) => _mapProcessingState(state.processingState));

  double get volume => _audioPlayer.volume;

  /// ファイルを読み込んで再生を開始
  Future<void> playFile(String filePath) async {
    await _audioPlayer.setFilePath(filePath);
    await _audioPlayer.play();
  }

  /// 再生を一時停止
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  /// 再生を再開
  Future<void> resume() async {
    await _audioPlayer.play();
  }

  /// 再生を停止
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  /// 指定位置へシーク
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  /// 音量を設定（0.0 - 1.0）
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  /// リソースを解放
  void dispose() {
    _audioPlayer.dispose();
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
