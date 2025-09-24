import 'package:flutter_srf/application/tracks/queried_tracks_provider.dart';
import 'package:flutter_srf/application/tracks/track.dart';
import 'package:flutter_srf/application/tracks/track_query_controller.dart';
import 'package:flutter_srf/application/tracks/tracks_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  group('TrackQueryController', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態は検索クエリが空でソートタイプがname', () {
      // Act
      final state = container.read(trackQueryControllerProvider);

      // Assert
      expect(state.searchQuery, '');
      expect(state.sortType, TrackSortType.name);
    });

    test('検索クエリを更新できる', () {
      // Arrange
      final _ = container.read(trackQueryControllerProvider.notifier)
        // Act
        ..updateSearchQuery('test query');

      // Assert
      final state = container.read(trackQueryControllerProvider);
      expect(state.searchQuery, 'test query');
    });

    test('検索クエリをクリアできる', () {
      // Arrange
      final _ = container.read(trackQueryControllerProvider.notifier)
        ..updateSearchQuery('test query')
        // Act
        ..clearSearchQuery();

      // Assert
      final state = container.read(trackQueryControllerProvider);
      expect(state.searchQuery, '');
    });

    test('ソートタイプを変更できる', () {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier)
        // Act & Assert - artist
        ..updateSortType(TrackSortType.artist);
      expect(container.read(trackQueryControllerProvider).sortType, TrackSortType.artist);

      // Act & Assert - album
      controller.updateSortType(TrackSortType.album);
      expect(container.read(trackQueryControllerProvider).sortType, TrackSortType.album);

      // Act & Assert - duration
      controller.updateSortType(TrackSortType.duration);
      expect(container.read(trackQueryControllerProvider).sortType, TrackSortType.duration);
    });
  });

  group('QueriedTracksProvider', () {
    late ProviderContainer container;

    // テスト用のトラックデータ
    final testTracks = [
      Track(
        id: '1',
        title: 'Amazing Grace',
        artist: 'John Smith',
        album: 'Gospel Collection',
        duration: 240,
        filePath: '/path/1.mp3',
        createdAt: DateTime(2024, 1, 1),
        modifiedAt: DateTime(2024, 1, 1),
      ),
      Track(
        id: '2',
        title: 'Beautiful Day',
        artist: 'Jane Doe',
        album: 'Pop Hits',
        duration: 180,
        filePath: '/path/2.mp3',
        createdAt: DateTime(2024, 1, 2),
        modifiedAt: DateTime(2024, 1, 2),
      ),
      Track(
        id: '3',
        title: 'Classical Symphony',
        artist: 'Orchestra',
        album: 'Classical Best',
        duration: 600,
        filePath: '/path/3.mp3',
        createdAt: DateTime(2024, 1, 3),
        modifiedAt: DateTime(2024, 1, 3),
      ),
      Track(
        id: '4',
        title: 'Dancing Queen',
        artist: 'Pop Band',
        album: 'Pop Hits',
        duration: 200,
        filePath: '/path/4.mp3',
        createdAt: DateTime(2024, 1, 4),
        modifiedAt: DateTime(2024, 1, 4),
      ),
    ];

    setUp(() {
      container = ProviderContainer(
        overrides: [
          tracksControllerProvider.overrideWith(() {
            return _MockTracksController(testTracks);
          }),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('検索クエリでフィルタリングできる（タイトル）', () async {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier);
      controller.updateSearchQuery('beautiful');

      // Act
      final tracks = await container.read(queriedTracksProvider.future);

      // Assert
      expect(tracks.length, 1);
      expect(tracks.first.title, 'Beautiful Day');
    });

    test('検索クエリでフィルタリングできる（アーティスト）', () async {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier);
      controller.updateSearchQuery('orchestra');

      // Act
      final tracks = await container.read(queriedTracksProvider.future);

      // Assert
      expect(tracks.length, 1);
      expect(tracks.first.artist, 'Orchestra');
    });

    test('検索クエリでフィルタリングできる（アルバム）', () async {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier);
      controller.updateSearchQuery('pop hits');

      // Act
      final tracks = await container.read(queriedTracksProvider.future);

      // Assert
      expect(tracks.length, 2);
      expect(tracks[0].album, 'Pop Hits');
      expect(tracks[1].album, 'Pop Hits');
    });

    test('名前順でソートできる', () async {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier);
      controller.updateSortType(TrackSortType.name);

      // Act
      final tracks = await container.read(queriedTracksProvider.future);

      // Assert
      expect(tracks[0].title, 'Amazing Grace');
      expect(tracks[1].title, 'Beautiful Day');
      expect(tracks[2].title, 'Classical Symphony');
      expect(tracks[3].title, 'Dancing Queen');
    });

    test('アーティスト順でソートできる', () async {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier);
      controller.updateSortType(TrackSortType.artist);

      // Act
      final tracks = await container.read(queriedTracksProvider.future);

      // Assert
      expect(tracks[0].artist, 'Jane Doe');
      expect(tracks[1].artist, 'John Smith');
      expect(tracks[2].artist, 'Orchestra');
      expect(tracks[3].artist, 'Pop Band');
    });

    test('アルバム順でソートできる', () async {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier);
      controller.updateSortType(TrackSortType.album);

      // Act
      final tracks = await container.read(queriedTracksProvider.future);

      // Assert
      expect(tracks[0].album, 'Classical Best');
      expect(tracks[1].album, 'Gospel Collection');
      expect(tracks[2].album, 'Pop Hits');
      expect(tracks[3].album, 'Pop Hits');
    });

    test('再生時間順でソートできる（長い順）', () async {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier);
      controller.updateSortType(TrackSortType.duration);

      // Act
      final tracks = await container.read(queriedTracksProvider.future);

      // Assert
      expect(tracks[0].duration, 600); // Classical Symphony
      expect(tracks[1].duration, 240); // Amazing Grace
      expect(tracks[2].duration, 200); // Dancing Queen
      expect(tracks[3].duration, 180); // Beautiful Day
    });

    test('検索とソートを組み合わせて使用できる', () async {
      // Arrange
      final controller = container.read(trackQueryControllerProvider.notifier);
      controller.updateSearchQuery('pop');
      controller.updateSortType(TrackSortType.duration);

      // Act
      final tracks = await container.read(queriedTracksProvider.future);

      // Assert
      expect(tracks.length, 2);
      expect(tracks[0].duration, 200); // Dancing Queen
      expect(tracks[1].duration, 180); // Beautiful Day
    });
  });
}

// テスト用のモックTracksController
class _MockTracksController extends TracksController {
  final List<Track> mockTracks;

  _MockTracksController(this.mockTracks);

  @override
  Future<TracksState> build() async {
    return TracksState(allTracks: mockTracks);
  }
}
