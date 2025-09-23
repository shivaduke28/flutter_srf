import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../tracks/track.dart';
import '../../system/audio/audio_player_service.dart';
import 'audio_player_state.dart';

part 'audio_player_controller.g.dart';

/// 音楽再生の状態管理とビジネスロジックを担当
@Riverpod(keepAlive: true)
class AudioPlayerController extends _$AudioPlayerController {
  late final AudioPlayerService _audioService;
  final _subscriptions = <StreamSubscription>[];

  @override
  AudioPlayerState build() {
    _audioService = ref.watch(audioPlayerServiceProvider);
    _setupListeners();

    ref.onDispose(() {
      for (final subscription in _subscriptions) {
        subscription.cancel();
      }
    });

    return AudioPlayerState(
      volume: _audioService.volume,
      currentContainer: null,
    );
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
            state = state.copyWith(
              status: PlayerStatus.stopped,
              position: Duration.zero,
              duration: Duration.zero,
            );
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
    state = state.copyWith(currentContainer: track);
    await _audioService.playFile(track.filePath);
  }

  /// 再生を一時停止
  Future<void> pause() async {
    await _audioService.pause();
  }

  /// 再生を再開
  Future<void> resume() async {
    await _audioService.resume();
  }

  /// 再生を停止
  Future<void> stop() async {
    await _audioService.stop();
    state = state.copyWith(
      currentContainer: null,
      position: Duration.zero,
      duration: Duration.zero,
      status: PlayerStatus.stopped,
    );
  }

  /// 指定位置へシーク
  Future<void> seek(Duration position) async {
    await _audioService.seek(position);
  }

  /// 再生/一時停止をトグル
  Future<void> togglePlayPause() async {
    if (state.status == PlayerStatus.playing) {
      await pause();
    } else if (state.status == PlayerStatus.paused &&
        state.currentContainer != null) {
      await resume();
    }
  }

  /// 音量を設定
  Future<void> setVolume(double volume) async {
    await _audioService.setVolume(volume);
  }
}
