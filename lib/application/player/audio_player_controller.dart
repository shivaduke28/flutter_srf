import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../tracks/track.dart';
import '../../system/audio/audio_player_service.dart';
import 'audio_player_state.dart';
import '../../errors/exceptions.dart';

part 'audio_player_controller.g.dart';

/// 音楽再生の状態管理とビジネスロジックを担当
@Riverpod(keepAlive: true)
class AudioPlayerController extends _$AudioPlayerController {
  late final AudioPlayerService _audioService;
  final _subscriptions = <StreamSubscription<dynamic>>[];

  @override
  AudioPlayerState build() {
    _audioService = ref.watch(audioPlayerServiceProvider);
    _setupListeners();

    ref.onDispose(() {
      for (final subscription in _subscriptions) {
        subscription.cancel();
      }
    });

    return AudioPlayerState(volume: _audioService.volume, currentContainer: null);
  }

  void _setupListeners() {
    // 再生状態の監視
    _subscriptions.add(
      _audioService.statusStream.listen((status) {
        switch (status) {
          case PlaybackStatus.playing:
            state = state.copyWith(status: PlayerStatus.playing);
            break;
          case PlaybackStatus.paused:
            state = state.copyWith(status: PlayerStatus.paused);
            break;
          case PlaybackStatus.stopped:
            state = state.copyWith(status: PlayerStatus.stopped, position: Duration.zero, duration: Duration.zero);
            break;
        }
      }),
    );

    // positionの監視
    _subscriptions.add(
      _audioService.positionStream.listen((position) {
        state = state.copyWith(position: position);
      }),
    );

    // durationの監視
    _subscriptions.add(
      _audioService.durationStream.listen((duration) {
        if (duration != null) {
          state = state.copyWith(duration: duration);
        }
      }),
    );

    // volumeの監視
    _subscriptions.add(
      _audioService.volumeStream.listen((volume) {
        state = state.copyWith(volume: volume);
      }),
    );

    // 処理状態の監視（再生完了時の処理）
    _subscriptions.add(
      _audioService.processingStateStream.listen((processingState) {
        if (processingState == AudioProcessingState.completed) {
          state = state.copyWith(
            currentContainer: null,
            status: PlayerStatus.stopped,
            position: Duration.zero,
            duration: Duration.zero,
          );
        }
      }),
    );
  }

  /// トラックを再生
  Future<void> play(Track track) async {
    try {
      state = state.copyWith(currentContainer: track);
      await _audioService.playFile(track.filePath);
    } on AppException {
      // エラー時は状態をリセット
      state = state.copyWith(currentContainer: null, status: PlayerStatus.stopped);
      // エラーを再スローしてUI層でキャッチできるようにする
      rethrow;
    }
  }

  /// 再生を一時停止
  Future<void> pause() async {
    try {
      await _audioService.pause();
    } on AppException {
      rethrow;
    }
  }

  /// 再生を再開
  Future<void> resume() async {
    try {
      await _audioService.resume();
    } on AppException {
      rethrow;
    }
  }

  /// 再生を停止
  Future<void> stop() async {
    try {
      await _audioService.stop();
      state = state.copyWith(
        currentContainer: null,
        position: Duration.zero,
        duration: Duration.zero,
        status: PlayerStatus.stopped,
      );
    } on AppException {
      // エラーが発生しても状態はリセット
      state = state.copyWith(
        currentContainer: null,
        position: Duration.zero,
        duration: Duration.zero,
        status: PlayerStatus.stopped,
      );
      rethrow;
    }
  }

  /// 指定位置へシーク
  Future<void> seek(Duration position) async {
    try {
      await _audioService.seek(position);
    } on AppException {
      rethrow;
    }
  }

  /// 再生/一時停止をトグル
  Future<void> togglePlayPause() async {
    try {
      if (state.status == PlayerStatus.playing) {
        await pause();
      } else if (state.status == PlayerStatus.paused && state.currentContainer != null) {
        await resume();
      }
    } on AppException {
      rethrow;
    }
  }

  /// 音量を設定
  Future<void> setVolume(double volume) async {
    try {
      await _audioService.setVolume(volume);
    } on AppException {
      rethrow;
    }
  }
}
