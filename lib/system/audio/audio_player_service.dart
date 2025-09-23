import 'dart:async';
import 'dart:io';
import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../errors/exceptions.dart';

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
  Stream<PlaybackStatus> get statusStream => _audioPlayer.playerStateStream.map((state) {
    if (state.playing) {
      return PlaybackStatus.playing;
    } else if (state.processingState == ProcessingState.idle || state.processingState == ProcessingState.completed) {
      return PlaybackStatus.stopped;
    } else {
      return PlaybackStatus.paused;
    }
  });

  Stream<Duration> get positionStream => _audioPlayer.positionStream;

  Stream<Duration?> get durationStream => _audioPlayer.durationStream;

  Stream<double> get volumeStream => _audioPlayer.volumeStream;

  Stream<AudioProcessingState> get processingStateStream =>
      _audioPlayer.playerStateStream.map((state) => _mapProcessingState(state.processingState));

  double get volume => _audioPlayer.volume;

  /// ファイルを読み込んで再生を開始
  Future<void> playFile(String filePath) async {
    try {
      // ファイルの存在確認
      final file = File(filePath);
      if (!await file.exists()) {
        throw FileNotFoundException(filePath: filePath);
      }

      await _audioPlayer.setFilePath(filePath);
      await _audioPlayer.play();
    } on FileNotFoundException {
      rethrow;
    } on PlayerException catch (e, stack) {
      throw AudioPlaybackException(message: '音楽ファイルの再生に失敗しました: ${e.message}', originalError: e, stackTrace: stack);
    } catch (e, stack) {
      throw AudioPlaybackException(message: '予期しないエラーが発生しました', originalError: e, stackTrace: stack);
    }
  }

  /// 再生を一時停止
  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } on PlayerException catch (e, stack) {
      throw AudioPlaybackException(message: '一時停止に失敗しました: ${e.message}', originalError: e, stackTrace: stack);
    }
  }

  /// 再生を再開
  Future<void> resume() async {
    try {
      await _audioPlayer.play();
    } on PlayerException catch (e, stack) {
      throw AudioPlaybackException(message: '再生の再開に失敗しました: ${e.message}', originalError: e, stackTrace: stack);
    }
  }

  /// 再生を停止
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } on PlayerException catch (e, stack) {
      throw AudioPlaybackException(message: '停止に失敗しました: ${e.message}', originalError: e, stackTrace: stack);
    }
  }

  /// 指定位置へシーク
  Future<void> seek(Duration position) async {
    try {
      // 負の値チェック
      if (position.isNegative) {
        throw ValidationException(message: 'シーク位置は0以上である必要があります');
      }

      // 長さを超えていないかチェック（可能な場合）
      final duration = _audioPlayer.duration;
      if (duration != null && position > duration) {
        throw ValidationException(message: 'シーク位置が楽曲の長さを超えています');
      }

      await _audioPlayer.seek(position);
    } on ValidationException {
      rethrow;
    } on PlayerException catch (e, stack) {
      throw AudioPlaybackException(message: 'シークに失敗しました: ${e.message}', originalError: e, stackTrace: stack);
    }
  }

  /// 音量を設定（0.0 - 1.0）
  Future<void> setVolume(double volume) async {
    try {
      if (volume < 0.0 || volume > 1.0) {
        throw ValidationException(message: '音量は0.0から1.0の範囲で指定してください');
      }
      await _audioPlayer.setVolume(volume);
    } on ValidationException {
      rethrow;
    } on PlayerException catch (e, stack) {
      throw AudioPlaybackException(message: '音量設定に失敗しました: ${e.message}', originalError: e, stackTrace: stack);
    }
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
