import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_srf/system/audio/audio_player_service.dart';
import 'package:flutter_srf/errors/exceptions.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AudioPlayerService Error Handling', () {
    late AudioPlayerService service;

    setUp(() {
      service = AudioPlayerService();
    });

    tearDown(() {
      service.dispose();
    });

    test('playFile() throws FileNotFoundException for non-existent file', () async {
      // Arrange
      const nonExistentFile = '/path/to/non/existent/file.mp3';

      // Act & Assert
      expect(
        () async => await service.playFile(nonExistentFile),
        throwsA(isA<FileNotFoundException>()),
      );
    });

    test('seek() throws ValidationException for negative duration', () async {
      // Arrange
      const negativeDuration = Duration(seconds: -1);

      // Act & Assert
      expect(
        () async => await service.seek(negativeDuration),
        throwsA(isA<ValidationException>()),
      );
    });

    test('setVolume() throws ValidationException for out-of-range volume', () async {
      // Act & Assert - Too low
      expect(
        () async => await service.setVolume(-0.1),
        throwsA(isA<ValidationException>()),
      );

      // Act & Assert - Too high
      expect(
        () async => await service.setVolume(1.1),
        throwsA(isA<ValidationException>()),
      );
    });

    test('setVolume() accepts valid volume range', () async {
      // Should not throw
      await service.setVolume(0.0);
      await service.setVolume(0.5);
      await service.setVolume(1.0);
    });
  });
}