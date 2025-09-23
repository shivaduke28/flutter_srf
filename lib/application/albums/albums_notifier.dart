import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'album.dart';
import '../tracks/track.dart';
import '../tracks/tracks_notifier.dart';

part 'albums_notifier.freezed.dart';
part 'albums_notifier.g.dart';

enum AlbumSortType { name, artist, trackCount }

@freezed
sealed class AlbumsState with _$AlbumsState {
  const factory AlbumsState({
    required List<Album> allAlbums,
    required String searchQuery,
    required AlbumSortType sortType,
  }) = _AlbumsState;
}

@Riverpod(keepAlive: true)
class AlbumsController extends _$AlbumsController {
  @override
  Future<AlbumsState> build() async {
    // TracksControllerの状態を監視
    final tracksState = await ref.watch(tracksControllerProvider.future);
    final tracks = tracksState.allTracks;

    // トラックからアルバムを生成
    final albumMap = <String, List<Track>>{};
    for (final track in tracks) {
      albumMap.putIfAbsent(track.album, () => []).add(track);
    }

    final allAlbums = albumMap.entries.map((entry) {
      final albumTracks = entry.value;
      final firstTrack = albumTracks.first;
      return Album(
        id: entry.key,
        name: entry.key,
        path: '', // Will be set properly later
        artist: firstTrack.artist,
        srfContainerIds: albumTracks.map((t) => t.id).toList(),
      );
    }).toList();

    return AlbumsState(
      allAlbums: allAlbums,
      searchQuery: '',
      sortType: AlbumSortType.name,
    );
  }

  List<Album> get filteredAndSortedAlbums {
    final currentState = state.valueOrNull;
    if (currentState == null) return [];

    var albums = List<Album>.from(currentState.allAlbums);

    // フィルタリング
    if (currentState.searchQuery.isNotEmpty) {
      final lowerQuery = currentState.searchQuery.toLowerCase();
      albums = albums.where((album) {
        return album.name.toLowerCase().contains(lowerQuery) ||
            (album.artist?.toLowerCase() ?? '').contains(lowerQuery);
      }).toList();
    }

    // ソート
    switch (currentState.sortType) {
      case AlbumSortType.name:
        albums.sort((a, b) => a.name.compareTo(b.name));
        break;
      case AlbumSortType.artist:
        albums.sort((a, b) => (a.artist ?? '').compareTo(b.artist ?? ''));
        break;
      case AlbumSortType.trackCount:
        albums.sort(
          (a, b) =>
              b.srfContainerIds.length.compareTo(a.srfContainerIds.length),
        );
        break;
    }

    return albums;
  }

  void updateSearchQuery(String query) {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncValue.data(currentState.copyWith(searchQuery: query));
    }
  }

  void clearSearchQuery() {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncValue.data(currentState.copyWith(searchQuery: ''));
    }
  }

  void updateSortType(AlbumSortType type) {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncValue.data(currentState.copyWith(sortType: type));
    }
  }
}
