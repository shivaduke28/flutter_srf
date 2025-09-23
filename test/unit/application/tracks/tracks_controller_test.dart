import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_srf/application/tracks/tracks_notifier.dart';
import 'package:flutter_srf/system/library/library_service.dart';
import 'package:flutter_srf/system/library/srf_file.dart';
import 'package:flutter_srf/system/library/srf_track.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'tracks_controller_test.mocks.dart';

@GenerateMocks([LibraryService])
void main() {
  group('TracksController', () {
    late ProviderContainer container;
    late MockLibraryService mockLibraryService;

    setUp(() {
      mockLibraryService = MockLibraryService();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期化時にトラックリストを取得する', () async {
      // Arrange
      final mockSrfFiles = [
        SrfFile(
          name: 'test.srf',
          path: '/test/test.srf',
          tracks: [
            SrfTrack(
              title: 'Test Track',
              artist: 'Test Artist',
              album: 'Test Album',
              path: '/test/track1.mp3',
              duration: 180,
            ),
          ],
        ),
      ];

      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => mockSrfFiles);

      container = ProviderContainer(overrides: [libraryServiceProvider.overrideWithValue(mockLibraryService)]);

      // Act
      final tracksState = await container.read(tracksControllerProvider.future);

      // Assert
      expect(tracksState.allTracks.length, 1);
      expect(tracksState.allTracks.first.title, 'Test Track');
      expect(tracksState.allTracks.first.artist, 'Test Artist');
      expect(tracksState.allTracks.first.album, 'Test Album');
    });

    test('refresh()でトラックリストを再読み込みする', () async {
      // Arrange
      final initialSrfFiles = [
        SrfFile(
          name: 'initial.srf',
          path: '/test/initial.srf',
          tracks: [
            SrfTrack(
              title: 'Initial Track',
              artist: 'Initial Artist',
              album: 'Initial Album',
              path: '/test/initial.mp3',
              duration: 180,
            ),
          ],
        ),
      ];

      final updatedSrfFiles = [
        SrfFile(
          name: 'updated.srf',
          path: '/test/updated.srf',
          tracks: [
            SrfTrack(
              title: 'Updated Track',
              artist: 'Updated Artist',
              album: 'Updated Album',
              path: '/test/updated.mp3',
              duration: 240,
            ),
          ],
        ),
      ];

      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => initialSrfFiles);

      container = ProviderContainer(overrides: [libraryServiceProvider.overrideWithValue(mockLibraryService)]);

      // Act - 初期読み込み
      final initialState = await container.read(tracksControllerProvider.future);
      expect(initialState.allTracks.first.title, 'Initial Track');

      // 更新されたデータを返すように設定
      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => updatedSrfFiles);

      // Act - リフレッシュ
      await container.read(tracksControllerProvider.notifier).refresh();

      // 状態が更新されるまで待つ
      final updatedState = await container.read(tracksControllerProvider.future);

      // Assert
      expect(updatedState.allTracks.length, 1);
      expect(updatedState.allTracks.first.title, 'Updated Track');
      expect(updatedState.allTracks.first.artist, 'Updated Artist');
    });

    test('空のライブラリの場合、空のトラックリストを返す', () async {
      // Arrange
      when(mockLibraryService.loadSrfFiles()).thenAnswer((_) async => []);

      container = ProviderContainer(overrides: [libraryServiceProvider.overrideWithValue(mockLibraryService)]);

      // Act
      final tracksState = await container.read(tracksControllerProvider.future);

      // Assert
      expect(tracksState.allTracks.isEmpty, true);
    });

    test('複数のSRFファイルからトラックを集約する', () async {
      // Arrange
      final mockSrfFiles = [
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

      container = ProviderContainer(overrides: [libraryServiceProvider.overrideWithValue(mockLibraryService)]);

      // Act
      final tracksState = await container.read(tracksControllerProvider.future);

      // Assert
      expect(tracksState.allTracks.length, 3);
      expect(tracksState.allTracks[0].title, 'Track 1');
      expect(tracksState.allTracks[1].title, 'Track 2');
      expect(tracksState.allTracks[2].title, 'Track 3');
      expect(tracksState.allTracks[2].artist, 'Artist 2');
    });
  });
}
