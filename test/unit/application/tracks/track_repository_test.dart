import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_srf/application/tracks/track_repository.dart';
import 'package:flutter_srf/system/library/library_service.dart';
import 'package:flutter_srf/system/library/srf_file.dart';
import 'package:flutter_srf/system/library/srf_track.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'track_repository_test.mocks.dart';

@GenerateMocks([LibraryService])
void main() {
  group('TrackRepository', () {
    late MockLibraryService mockLibraryService;
    late TrackRepository repository;

    setUp(() {
      mockLibraryService = MockLibraryService();
      repository = TrackRepository(mockLibraryService);
    });

    test('getAllTracks()で全トラックを取得できる', () async {
      // Arrange
      final List<SrfFile> mockSrfFiles = [
        SrfFile(
          name: 'album1.srf',
          path: '/test/album1.srf',
          tracks: [
            SrfTrack(title: 'Track 1', artist: 'Artist 1', album: 'Album 1', path: '/test/track1.mp3', duration: 180),
            SrfTrack(title: 'Track 2', artist: 'Artist 1', album: 'Album 1', path: '/test/track2.mp3', duration: 200),
          ],
        ),
        SrfFile(
          name: 'album2.srf',
          path: '/test/album2.srf',
          tracks: [
            SrfTrack(title: 'Track 3', artist: 'Artist 2', album: 'Album 2', path: '/test/track3.mp3', duration: 220),
          ],
        ),
      ];

      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => mockSrfFiles);

      // Act
      final tracks = await repository.getAllTracks();

      // Assert
      expect(tracks.length, 3);
      expect(tracks[0].title, 'Track 1');
      expect(tracks[0].artist, 'Artist 1');
      expect(tracks[0].album, 'Album 1');
      expect(tracks[0].duration, 180);
      expect(tracks[0].filePath, '/test/track1.mp3');

      expect(tracks[1].title, 'Track 2');
      expect(tracks[1].artist, 'Artist 1');
      expect(tracks[1].album, 'Album 1');
      expect(tracks[1].duration, 200);
      expect(tracks[1].filePath, '/test/track2.mp3');

      expect(tracks[2].title, 'Track 3');
      expect(tracks[2].artist, 'Artist 2');
      expect(tracks[2].album, 'Album 2');
      expect(tracks[2].duration, 220);
      expect(tracks[2].filePath, '/test/track3.mp3');

      verify(mockLibraryService.loadSrfFiles()).called(1);
    });

    test('空のライブラリの場合、空のリストを返す', () async {
      // Arrange
      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => []);

      // Act
      final tracks = await repository.getAllTracks();

      // Assert
      expect(tracks.isEmpty, true);
      verify(mockLibraryService.loadSrfFiles()).called(1);
    });

    test('同じアルバム内のトラックが正しくマッピングされる', () async {
      // Arrange
      final List<SrfFile> mockSrfFiles = [
        SrfFile(
          name: 'album.srf',
          path: '/test/album.srf',
          tracks: [
            SrfTrack(
              title: 'Track A',
              artist: 'Common Artist',
              album: 'Common Album',
              path: '/test/track_a.mp3',
              duration: 180,
            ),
            SrfTrack(
              title: 'Track B',
              artist: 'Common Artist',
              album: 'Common Album',
              path: '/test/track_b.mp3',
              duration: 200,
            ),
            SrfTrack(
              title: 'Track C',
              artist: 'Common Artist',
              album: 'Common Album',
              path: '/test/track_c.mp3',
              duration: 220,
            ),
          ],
        ),
      ];

      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => mockSrfFiles);

      // Act
      final tracks = await repository.getAllTracks();

      // Assert
      expect(tracks.length, 3);
      expect(tracks.every((t) => t.artist == 'Common Artist'), true);
      expect(tracks.every((t) => t.album == 'Common Album'), true);
      expect(tracks.map((t) => t.title).toList(), ['Track A', 'Track B', 'Track C']);
    });

    test('各トラックにユニークなIDが生成される', () async {
      // Arrange
      final List<SrfFile> mockSrfFiles = [
        SrfFile(
          name: 'test.srf',
          path: '/test/test.srf',
          tracks: [
            SrfTrack(title: 'Track 1', artist: 'Artist', album: 'Album', path: '/test/track1.mp3', duration: 180),
            SrfTrack(title: 'Track 2', artist: 'Artist', album: 'Album', path: '/test/track2.mp3', duration: 200),
          ],
        ),
      ];

      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => mockSrfFiles);

      // Act
      final tracks = await repository.getAllTracks();

      // Assert
      expect(tracks.length, 2);
      expect(tracks[0].id, isNotEmpty);
      expect(tracks[1].id, isNotEmpty);
      expect(tracks[0].id != tracks[1].id, true);
    });

    test('作成日時と更新日時が正しく設定される', () async {
      // Arrange
      final List<SrfFile> mockSrfFiles = [
        SrfFile(
          name: 'test.srf',
          path: '/test/test.srf',
          tracks: [SrfTrack(title: 'Track', artist: 'Artist', album: 'Album', path: '/test/track.mp3', duration: 180)],
        ),
      ];

      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => mockSrfFiles);

      // Act
      final tracks = await repository.getAllTracks();

      // Assert
      expect(tracks.length, 1);
      // createdAtとmodifiedAtはTrackクラスで自動生成されるのでチェック
      expect(tracks[0].createdAt, isNotNull);
      expect(tracks[0].modifiedAt, isNotNull);
    });
  });
}
