import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'albums_provider.dart';

part 'albums_controller.freezed.dart';
part 'albums_controller.g.dart';

enum AlbumSortType { name, artist, trackCount }

@freezed
sealed class AlbumsState with _$AlbumsState {
  const factory AlbumsState({
    required List<AlbumInfo> allAlbums,
    required String searchQuery,
    required AlbumSortType sortType,
  }) = _AlbumsState;
}

@riverpod
class AlbumsController extends _$AlbumsController {
  @override
  Future<AlbumsState> build() async {
    final allAlbums = await ref.watch(albumListProvider.future);
    return AlbumsState(
      allAlbums: allAlbums,
      searchQuery: '',
      sortType: AlbumSortType.name,
    );
  }

  List<AlbumInfo> get filteredAndSortedAlbums {
    final currentState = state.valueOrNull;
    if (currentState == null) return [];

    var albums = List<AlbumInfo>.from(currentState.allAlbums);

    // フィルタリング
    if (currentState.searchQuery.isNotEmpty) {
      final lowerQuery = currentState.searchQuery.toLowerCase();
      albums = albums.where((album) {
        return album.name.toLowerCase().contains(lowerQuery) ||
            album.artist.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    // ソート
    switch (currentState.sortType) {
      case AlbumSortType.name:
        albums.sort((a, b) => a.name.compareTo(b.name));
        break;
      case AlbumSortType.artist:
        albums.sort((a, b) => a.artist.compareTo(b.artist));
        break;
      case AlbumSortType.trackCount:
        albums.sort((a, b) => b.trackCount.compareTo(a.trackCount));
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
