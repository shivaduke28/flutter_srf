import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_srf/application/player/audio_player_controller.dart';
import 'package:flutter_srf/application/player/audio_player_state.dart';
import 'package:flutter_srf/application/tracks/track.dart';
import 'package:flutter_srf/system/audio/audio_player_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'audio_player_controller_test.mocks.dart';

@GenerateMocks([AudioPlayerService])
void main() {
  group('AudioPlayerController', () {
    late ProviderContainer container;
    late MockAudioPlayerService mockAudioService;
    late StreamController<PlaybackStatus> statusStreamController;
    late StreamController<Duration> positionStreamController;
    late StreamController<Duration?> durationStreamController;
    late StreamController<double> volumeStreamController;
    late StreamController<AudioProcessingState> processingStateStreamController;

    setUp(() {
      mockAudioService = MockAudioPlayerService();
      statusStreamController = StreamController<PlaybackStatus>.broadcast();
      positionStreamController = StreamController<Duration>.broadcast();
      durationStreamController = StreamController<Duration?>.broadcast();
      volumeStreamController = StreamController<double>.broadcast();
      processingStateStreamController = StreamController<AudioProcessingState>.broadcast();

      // モックの設定
      when(mockAudioService.statusStream)
          .thenAnswer((_) => statusStreamController.stream);
      when(mockAudioService.positionStream)
          .thenAnswer((_) => positionStreamController.stream);
      when(mockAudioService.durationStream)
          .thenAnswer((_) => durationStreamController.stream);
      when(mockAudioService.volumeStream)
          .thenAnswer((_) => volumeStreamController.stream);
      when(mockAudioService.processingStateStream)
          .thenAnswer((_) => processingStateStreamController.stream);
      when(mockAudioService.volume).thenReturn(1.0);

      container = ProviderContainer(
        overrides: [
          audioPlayerServiceProvider.overrideWithValue(mockAudioService),
        ],
      );
    });

    tearDown(() {
      statusStreamController.close();
      positionStreamController.close();
      durationStreamController.close();
      volumeStreamController.close();
      processingStateStreamController.close();
      container.dispose();
    });

    test('初期状態は停止状態で音量1.0', () {
      // Act
      final state = container.read(audioPlayerControllerProvider);

      // Assert
      expect(state.status, PlayerStatus.stopped);
      expect(state.volume, 1.0);
      expect(state.currentContainer, isNull);
      expect(state.position, Duration.zero);
      expect(state.duration, Duration.zero);
    });

    test('play()でトラックを再生できる', () async {
      // Arrange
      final track = Track(
        id: '1',
        title: 'Test Track',
        artist: 'Test Artist',
        album: 'Test Album',
        duration: 180,
        filePath: '/test/track.mp3',
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      when(mockAudioService.playFile(track.filePath))
          .thenAnswer((_) async {});

      final controller = container.read(audioPlayerControllerProvider.notifier);

      // Act
      await controller.play(track);

      // Assert
      final state = container.read(audioPlayerControllerProvider);
      expect(state.currentContainer, track);
      verify(mockAudioService.playFile(track.filePath)).called(1);
    });

    test('pause()で一時停止できる', () async {
      // Arrange
      when(mockAudioService.pause()).thenAnswer((_) async {});
      final controller = container.read(audioPlayerControllerProvider.notifier);

      // Act
      await controller.pause();

      // Assert
      verify(mockAudioService.pause()).called(1);
    });

    test('resume()で再生を再開できる', () async {
      // Arrange
      when(mockAudioService.resume()).thenAnswer((_) async {});
      final controller = container.read(audioPlayerControllerProvider.notifier);

      // Act
      await controller.resume();

      // Assert
      verify(mockAudioService.resume()).called(1);
    });

    test('stop()で再生を停止し状態をリセットする', () async {
      // Arrange
      final track = Track(
        id: '1',
        title: 'Test Track',
        artist: 'Test Artist',
        album: 'Test Album',
        duration: 180,
        filePath: '/test/track.mp3',
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      when(mockAudioService.playFile(track.filePath))
          .thenAnswer((_) async {});
      when(mockAudioService.stop()).thenAnswer((_) async {});

      final controller = container.read(audioPlayerControllerProvider.notifier);

      // トラックを再生
      await controller.play(track);
      expect(container.read(audioPlayerControllerProvider).currentContainer, track);

      // Act
      await controller.stop();

      // Assert
      final state = container.read(audioPlayerControllerProvider);
      expect(state.currentContainer, isNull);
      expect(state.position, Duration.zero);
      expect(state.duration, Duration.zero);
      expect(state.status, PlayerStatus.stopped);
      verify(mockAudioService.stop()).called(1);
    });

    test('seek()で指定位置にシークできる', () async {
      // Arrange
      final position = const Duration(seconds: 30);
      when(mockAudioService.seek(position)).thenAnswer((_) async {});
      final controller = container.read(audioPlayerControllerProvider.notifier);

      // Act
      await controller.seek(position);

      // Assert
      verify(mockAudioService.seek(position)).called(1);
    });

    test('setVolume()で音量を設定できる', () async {
      // Arrange
      const volume = 0.5;
      when(mockAudioService.setVolume(volume)).thenAnswer((_) async {});
      final controller = container.read(audioPlayerControllerProvider.notifier);

      // Act
      await controller.setVolume(volume);

      // Assert
      verify(mockAudioService.setVolume(volume)).called(1);
    });

    test('togglePlayPause()で再生/一時停止を切り替えできる', () async {
      // Arrange
      final track = Track(
        id: '1',
        title: 'Test Track',
        artist: 'Test Artist',
        album: 'Test Album',
        duration: 180,
        filePath: '/test/track.mp3',
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      when(mockAudioService.playFile(track.filePath))
          .thenAnswer((_) async {});
      when(mockAudioService.pause()).thenAnswer((_) async {});
      when(mockAudioService.resume()).thenAnswer((_) async {});

      final controller = container.read(audioPlayerControllerProvider.notifier);

      // トラックを再生して再生状態にする
      await controller.play(track);
      // 手動で状態を更新（ストリームイベントをシミュレート）
      statusStreamController.add(PlaybackStatus.playing);
      await Future.delayed(const Duration(milliseconds: 100));

      // Act - 再生中から一時停止へ
      await controller.togglePlayPause();

      // Assert
      verify(mockAudioService.pause()).called(1);

      // 状態を一時停止に更新
      statusStreamController.add(PlaybackStatus.paused);
      await Future.delayed(const Duration(milliseconds: 100));

      // Act - 一時停止から再生へ
      await controller.togglePlayPause();

      // Assert
      verify(mockAudioService.resume()).called(1);
    });

    test('ストリームイベントで状態が更新される', () async {
      // Arrange
      // まずControllerを初期化してリスナーを設定
      final _ = container.read(audioPlayerControllerProvider);

      // Act & Assert - 再生状態
      statusStreamController.add(PlaybackStatus.playing);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(container.read(audioPlayerControllerProvider).status,
             PlayerStatus.playing);

      // Act & Assert - 一時停止状態
      statusStreamController.add(PlaybackStatus.paused);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(container.read(audioPlayerControllerProvider).status,
             PlayerStatus.paused);

      // Act & Assert - 停止状態
      statusStreamController.add(PlaybackStatus.stopped);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(container.read(audioPlayerControllerProvider).status,
             PlayerStatus.stopped);

      // Act & Assert - 位置の更新
      positionStreamController.add(const Duration(seconds: 45));
      await Future.delayed(const Duration(milliseconds: 100));
      expect(container.read(audioPlayerControllerProvider).position,
             const Duration(seconds: 45));

      // Act & Assert - 長さの更新
      durationStreamController.add(const Duration(seconds: 180));
      await Future.delayed(const Duration(milliseconds: 100));
      expect(container.read(audioPlayerControllerProvider).duration,
             const Duration(seconds: 180));

      // Act & Assert - 音量の更新
      volumeStreamController.add(0.7);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(container.read(audioPlayerControllerProvider).volume, 0.7);
    });

    test('再生完了時に状態がリセットされる', () async {
      // Arrange
      final track = Track(
        id: '1',
        title: 'Test Track',
        artist: 'Test Artist',
        album: 'Test Album',
        duration: 180,
        filePath: '/test/track.mp3',
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      when(mockAudioService.playFile(track.filePath))
          .thenAnswer((_) async {});

      final controller = container.read(audioPlayerControllerProvider.notifier);

      // トラックを再生
      await controller.play(track);
      expect(container.read(audioPlayerControllerProvider).currentContainer, track);

      // Act - 再生完了イベントを送信
      processingStateStreamController.add(AudioProcessingState.completed);
      await Future.delayed(const Duration(milliseconds: 100));

      // Assert
      final state = container.read(audioPlayerControllerProvider);
      expect(state.currentContainer, isNull);
      expect(state.status, PlayerStatus.stopped);
      expect(state.position, Duration.zero);
      expect(state.duration, Duration.zero);
    });
  });
}