import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'track.dart';
import '../library/library_manager.dart';

part 'tracks_notifier.freezed.dart';
part 'tracks_notifier.g.dart';

enum TrackSortType { title, artist, album, dateAdded }

@freezed
sealed class TracksState with _$TracksState {
  const factory TracksState({
    required List<Track> allTracks,
    required String searchQuery,
    required TrackSortType sortType,
  }) = _TracksState;
}

@Riverpod(keepAlive: true)
class TracksController extends _$TracksController {
  @override
  Future<TracksState> build() async {
    // LibraryManagerの状態を監視して、変更があったら再ビルド
    final libraryTracks = ref.watch(libraryManagerProvider);

    // LibraryManagerのトラックをそのまま使用
    return TracksState(
      allTracks: libraryTracks,
      searchQuery: '',
      sortType: TrackSortType.title,
    );
  }

  List<Track> get filteredAndSortedTracks {
    final currentState = state.valueOrNull;
    if (currentState == null) return [];

    var tracks = List<Track>.from(currentState.allTracks);

    // フィルタリング
    if (currentState.searchQuery.isNotEmpty) {
      final lowerQuery = currentState.searchQuery.toLowerCase();
      tracks = tracks.where((track) {
        return track.title.toLowerCase().contains(lowerQuery) ||
            track.artist.toLowerCase().contains(lowerQuery) ||
            track.album.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    // ソート
    switch (currentState.sortType) {
      case TrackSortType.title:
        tracks.sort((a, b) => a.title.compareTo(b.title));
        break;
      case TrackSortType.artist:
        tracks.sort((a, b) => a.artist.compareTo(b.artist));
        break;
      case TrackSortType.album:
        tracks.sort((a, b) => a.album.compareTo(b.album));
        break;
      case TrackSortType.dateAdded:
        // TODO: implement date tracking
        break;
    }

    return tracks;
  }

  void updateSearchQuery(String query) {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(searchQuery: query));
    }
  }

  void clearSearchQuery() {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(searchQuery: ''));
    }
  }

  void updateSortType(TrackSortType type) {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(sortType: type));
    }
  }

  Future<void> refresh() async {
    // LibraryManagerのscanLibraryを呼んで再スキャン
    await ref.read(libraryManagerProvider.notifier).scanLibrary(forceRefresh: true);
    final tracks = ref.read(libraryManagerProvider);
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(allTracks: tracks));
    }
  }
}
