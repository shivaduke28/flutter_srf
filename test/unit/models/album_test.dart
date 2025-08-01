import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_srf/models/album.dart';

void main() {
  group('Album', () {
    test('デフォルト値で作成できる', () {
      // Arrange & Act
      final album = Album(
        id: 'album-1',
        name: 'Test Album',
        path: '/path/to/album',
        artist: 'Test Artist',
        srfContainerIds: ['id1', 'id2'],
      );

      // Assert
      expect(album.name, 'Test Album');
      expect(album.artist, 'Test Artist');
      expect(album.srfContainerIds, ['id1', 'id2']);
      expect(album.coverImagePath, null);
      expect(album.year, null);
    });

    test('全てのフィールドを指定して作成できる', () {
      // Arrange & Act
      final album = Album(
        id: 'album-1',
        name: 'Test Album',
        path: '/path/to/album',
        artist: 'Test Artist',
        srfContainerIds: ['id1', 'id2'],
        coverImagePath: '/path/to/art.jpg',
        year: 2024,
      );

      // Assert
      expect(album.name, 'Test Album');
      expect(album.artist, 'Test Artist');
      expect(album.srfContainerIds, ['id1', 'id2']);
      expect(album.coverImagePath, '/path/to/art.jpg');
      expect(album.year, 2024);
    });

    test('copyWithが正しく動作する', () {
      // Arrange
      final original = Album(
        id: 'album-1',
        name: 'Original Album',
        path: '/path/to/original',
        artist: 'Original Artist',
        srfContainerIds: ['id1'],
        year: 2023,
      );

      // Act
      final updated = original.copyWith(
        name: 'Updated Album',
        srfContainerIds: ['id1', 'id2', 'id3'],
      );

      // Assert
      expect(updated.name, 'Updated Album');
      expect(updated.artist, 'Original Artist');
      expect(updated.srfContainerIds, ['id1', 'id2', 'id3']);
      expect(updated.year, 2023);
    });

    test('コンテナIDの追加・削除ができる', () {
      // Arrange
      final album = Album(
        id: 'album-1',
        name: 'Test Album',
        path: '/path/to/album',
        artist: 'Test Artist',
        srfContainerIds: ['id1', 'id2'],
      );

      // Act - コンテナIDを追加
      final withAdded = album.copyWith(
        srfContainerIds: [...album.srfContainerIds, 'id3'],
      );

      // Assert
      expect(withAdded.srfContainerIds, ['id1', 'id2', 'id3']);

      // Act - コンテナIDを削除
      final withRemoved = withAdded.copyWith(
        srfContainerIds: withAdded.srfContainerIds.where((id) => id != 'id2').toList(),
      );

      // Assert
      expect(withRemoved.srfContainerIds, ['id1', 'id3']);
    });

    test('等価性が正しく判定される', () {
      // Arrange
      final album1 = Album(
        id: 'album-1',
        name: 'Same Album',
        path: '/path/1',
        artist: 'Same Artist',
        srfContainerIds: ['id1', 'id2'],
      );
      final album2 = Album(
        id: 'album-1',
        name: 'Same Album',
        path: '/path/1',
        artist: 'Same Artist',
        srfContainerIds: ['id1', 'id2'],
      );
      final album3 = Album(
        id: 'album-2',
        name: 'Different Album',
        path: '/path/2',
        artist: 'Same Artist',
        srfContainerIds: ['id1', 'id2'],
      );

      // Assert
      expect(album1, equals(album2));
      expect(album1, isNot(equals(album3)));
    });

    test('ソート用の比較が正しく動作する', () {
      // Arrange
      final albums = [
        Album(id: '1', name: 'B Album', path: '/b', artist: 'B Artist', srfContainerIds: []),
        Album(id: '2', name: 'A Album', path: '/a', artist: 'C Artist', srfContainerIds: []),
        Album(id: '3', name: 'C Album', path: '/c', artist: 'A Artist', srfContainerIds: []),
      ];

      // Act - アルバム名でソート
      final sortedByName = [...albums]
        ..sort((a, b) => a.name.compareTo(b.name));

      // Act - アーティスト名でソート
      final sortedByArtist = [...albums]
        ..sort((a, b) => (a.artist ?? '').compareTo(b.artist ?? ''));

      // Assert
      expect(sortedByName.map((a) => a.name), ['A Album', 'B Album', 'C Album']);
      expect(sortedByArtist.map((a) => a.artist), ['A Artist', 'B Artist', 'C Artist']);
    });
  });
}