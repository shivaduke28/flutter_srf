import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_srf/models/srf_container.dart';
import 'package:flutter_srf/models/srf_metadata.dart';

void main() {
  group('SrfContainer', () {
    test('デフォルト値で作成できる', () {
      // Arrange & Act
      final container = SrfContainer(
        id: 'test-id',
        name: 'Test Container',
        path: '/test/path',
        metadata: SrfMetadata(
          title: 'Test Song',
          artist: 'Test Artist',
          duration: 180.0,
        ),
        audioFiles: ['audio.mp3'],
      );

      // Assert
      expect(container.id, 'test-id');
      expect(container.name, 'Test Container');
      expect(container.path, '/test/path');
      expect(container.createdAt, null);
      expect(container.modifiedAt, null);
      expect(container.metadata.title, 'Test Song');
      expect(container.metadata.artist, 'Test Artist');
      expect(container.audioFiles, ['audio.mp3']);
    });

    test('全てのフィールドを指定して作成できる', () {
      // Arrange
      final now = DateTime.now();
      final metadata = SrfMetadata(
        title: 'Test Song',
        artist: 'Test Artist',
        duration: 180.0,
        album: 'Test Album',
      );

      // Act
      final container = SrfContainer(
        id: 'test-id',
        name: 'Test Container',
        path: '/test/path',
        createdAt: now,
        modifiedAt: now,
        metadata: metadata,
        audioFiles: ['audio1.mp3', 'audio2.mp3'],
      );

      // Assert
      expect(container.id, 'test-id');
      expect(container.name, 'Test Container');
      expect(container.path, '/test/path');
      expect(container.createdAt, now);
      expect(container.modifiedAt, now);
      expect(container.metadata, metadata);
      expect(container.audioFiles, ['audio1.mp3', 'audio2.mp3']);
    });

    test('copyWithが正しく動作する', () {
      // Arrange
      final original = SrfContainer(
        id: 'original-id',
        name: 'Original Container',
        path: '/original/path',
        metadata: SrfMetadata(
          title: 'Original Song',
          artist: 'Original Artist',
          duration: 200.0,
        ),
        audioFiles: ['original.mp3'],
      );

      // Act
      final updated = original.copyWith(
        name: 'Updated Container',
        audioFiles: ['updated1.mp3', 'updated2.mp3'],
      );

      // Assert
      expect(updated.id, 'original-id');
      expect(updated.name, 'Updated Container');
      expect(updated.path, '/original/path');
      expect(updated.metadata.title, 'Original Song');
      expect(updated.audioFiles, ['updated1.mp3', 'updated2.mp3']);
      expect(updated.createdAt, original.createdAt);
      expect(updated.modifiedAt, original.modifiedAt);
    });

    test('fromJsonが正しく動作する', () {
      // Arrange
      final now = DateTime.now();
      final json = {
        'id': 'json-id',
        'name': 'JSON Container',
        'path': '/json/path',
        'createdAt': now.toIso8601String(),
        'modifiedAt': now.toIso8601String(),
        'metadata': {
          'title': 'JSON Song',
          'artist': 'JSON Artist',
          'duration': 180.0,
        },
        'audioFiles': ['json.mp3'],
      };

      // Act
      final container = SrfContainer.fromJson(json);

      // Assert
      expect(container.id, 'json-id');
      expect(container.name, 'JSON Container');
      expect(container.path, '/json/path');
      expect(container.metadata.title, 'JSON Song');
      expect(container.metadata.artist, 'JSON Artist');
      expect(container.audioFiles, ['json.mp3']);
    });

    test('toJsonが正しく動作する', () {
      // Arrange
      final container = SrfContainer(
        id: 'test-id',
        name: 'Test Container',
        path: '/test/path',
        metadata: SrfMetadata(
          title: 'Test Song',
          artist: 'Test Artist',
          duration: 180.0,
        ),
        audioFiles: ['test.mp3'],
      );

      // Act
      final json = container.toJson();

      // Assert
      expect(json['id'], 'test-id');
      expect(json['name'], 'Test Container');
      expect(json['path'], '/test/path');
      expect(json['createdAt'], anyOf(isNull, isA<String>()));
      expect(json['modifiedAt'], anyOf(isNull, isA<String>()));
      // metadataはtoJsonメソッドによって変換されているはず
      expect(json['metadata'], isA<Map<String, dynamic>>());
      final metadata = json['metadata'] as Map<String, dynamic>;
      expect(metadata['title'], 'Test Song');
      expect(metadata['artist'], 'Test Artist');
      expect(metadata['duration'], 180.0);
      expect(json['audioFiles'], ['test.mp3']);
    });

    test('ソート用の比較が正しく動作する', () {
      // Arrange
      final container1 = SrfContainer(
        id: '1',
        name: 'A Container',
        path: '/a',
        metadata: SrfMetadata(title: 'A Song', artist: 'A Artist', duration: 180.0),
        audioFiles: [],
      );
      final container2 = SrfContainer(
        id: '2',
        name: 'B Container',
        path: '/b',
        metadata: SrfMetadata(title: 'B Song', artist: 'B Artist', duration: 180.0),
        audioFiles: [],
      );
      final container3 = SrfContainer(
        id: '3',
        name: 'C Container',
        path: '/c',
        metadata: SrfMetadata(title: 'C Song', artist: 'A Artist', duration: 180.0),
        audioFiles: [],
      );

      // Act
      final sortedByTitle = [container3, container1, container2]
        ..sort((a, b) => a.metadata.title.compareTo(b.metadata.title));
      
      final sortedByArtist = [container2, container3, container1]
        ..sort((a, b) => a.metadata.artist.compareTo(b.metadata.artist));

      // Assert
      expect(sortedByTitle.map((c) => c.metadata.title), ['A Song', 'B Song', 'C Song']);
      expect(sortedByArtist.map((c) => c.metadata.artist), ['A Artist', 'A Artist', 'B Artist']);
    });
  });
}