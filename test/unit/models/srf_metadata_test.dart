import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_srf/models/srf_metadata.dart';

void main() {
  group('SrfMetadata', () {
    test('デフォルト値で作成できる', () {
      // Arrange & Act
      final metadata = SrfMetadata(
        title: 'Test Song',
        artist: 'Test Artist',
        duration: 180.0,
      );

      // Assert
      expect(metadata.title, 'Test Song');
      expect(metadata.artist, 'Test Artist');
      expect(metadata.album, null);
      expect(metadata.genre, null);
      expect(metadata.year, null);
      expect(metadata.duration, 180.0);
    });

    test('全てのフィールドを指定して作成できる', () {
      // Arrange & Act
      final metadata = SrfMetadata(
        title: 'Test Song',
        artist: 'Test Artist',
        duration: 180.0,
        album: 'Test Album',
        genre: 'Rock',
        year: 2024,
      );

      // Assert
      expect(metadata.title, 'Test Song');
      expect(metadata.artist, 'Test Artist');
      expect(metadata.album, 'Test Album');
      expect(metadata.genre, 'Rock');
      expect(metadata.year, 2024);
      expect(metadata.duration, 180.0);
    });

    test('copyWithが正しく動作する', () {
      // Arrange
      final original = SrfMetadata(
        title: 'Original',
        artist: 'Original Artist',
        duration: 200.0,
        album: 'Original Album',
        genre: 'Pop',
        year: 2023,
      );

      // Act
      final updated = original.copyWith(
        title: 'Updated',
        year: 2024,
      );

      // Assert
      expect(updated.title, 'Updated');
      expect(updated.artist, 'Original Artist');
      expect(updated.album, 'Original Album');
      expect(updated.genre, 'Pop');
      expect(updated.year, 2024);
      expect(updated.duration, 200.0);
    });

    test('fromJsonが正しく動作する', () {
      // Arrange
      final json = {
        'title': 'JSON Song',
        'artist': 'JSON Artist',
        'duration': 240.0,
        'album': 'JSON Album',
        'genre': 'Electronic',
        'year': 2024,
      };

      // Act
      final metadata = SrfMetadata.fromJson(json);

      // Assert
      expect(metadata.title, 'JSON Song');
      expect(metadata.artist, 'JSON Artist');
      expect(metadata.album, 'JSON Album');
      expect(metadata.genre, 'Electronic');
      expect(metadata.year, 2024);
      expect(metadata.duration, 240.0);
    });

    test('toJsonが正しく動作する', () {
      // Arrange
      final metadata = SrfMetadata(
        title: 'Test Song',
        artist: 'Test Artist',
        duration: 300.0,
        album: 'Test Album',
        genre: 'Jazz',
        year: 2024,
      );

      // Act
      final json = metadata.toJson();

      // Assert
      expect(json['title'], 'Test Song');
      expect(json['artist'], 'Test Artist');
      expect(json['album'], 'Test Album');
      expect(json['genre'], 'Jazz');
      expect(json['year'], 2024);
      expect(json['duration'], 300.0);
    });

    test('等価性が正しく判定される', () {
      // Arrange
      final metadata1 = SrfMetadata(
        title: 'Same Song',
        artist: 'Same Artist',
        duration: 180.0,
      );
      final metadata2 = SrfMetadata(
        title: 'Same Song',
        artist: 'Same Artist',
        duration: 180.0,
      );
      final metadata3 = SrfMetadata(
        title: 'Different Song',
        artist: 'Same Artist',
        duration: 180.0,
      );

      // Assert
      expect(metadata1, equals(metadata2));
      expect(metadata1, isNot(equals(metadata3)));
    });
  });
}