import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_srf/services/audio_player_service.dart';
import 'package:flutter/widgets.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AudioPlayerService', () {
    late AudioPlayerService service;

    setUp(() {
      service = AudioPlayerService();
    });

    test('初期状態が正しい', () {
      // Act & Assert
      expect(service.player, isNotNull);
      expect(service.volume, 1.0); // just_audioのデフォルト音量
    });

    test('音量を設定できる', () async {
      // Arrange
      const newVolume = 0.8;
      
      // Act
      await service.setVolume(newVolume);
      
      // Assert
      expect(service.volume, 0.8);
    });

    test('音量が0.0から1.0の範囲に制限される', () async {
      // Act & Assert - 上限
      await service.setVolume(1.5);
      expect(service.volume, 1.0);
      
      // Act & Assert - 下限
      await service.setVolume(-0.5);
      expect(service.volume, 0.0);
    });

    test('一時停止と再開ができる', () async {
      // このテストは実際のAudioPlayerの動作に依存するため
      // エラーが発生しないことのみをテスト
      
      // Act & Assert
      expect(() => service.pause(), returnsNormally);
      expect(() => service.resume(), returnsNormally);
    }, skip: 'AudioPlayerの初期化に時間がかかるため');

    test('停止ができる', () async {
      // Act & Assert
      await expectLater(service.stop(), completes);
    });

    test('シークができる', () async {
      // Act & Assert
      await expectLater(
        service.seek(const Duration(seconds: 10)), 
        completes,
      );
    });

    test('disposeメソッドが呼ばれる', () {
      // Act & Assert
      expect(() => service.dispose(), returnsNormally);
    });

    tearDown(() {
      service.dispose();
    });
  });
}