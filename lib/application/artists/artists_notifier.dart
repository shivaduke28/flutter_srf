import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'artist.dart';
import '../tracks/tracks_notifier.dart';

part 'artists_notifier.freezed.dart';
part 'artists_notifier.g.dart';

enum ArtistSortType { name, albumCount, trackCount }

@freezed
sealed class ArtistsState with _$ArtistsState {
  const factory ArtistsState({
    required List<Artist> allArtists,
    required String searchQuery,
    required ArtistSortType sortType,
  }) = _ArtistsState;
}

@Riverpod(keepAlive: true)
class ArtistsController extends _$ArtistsController {
  @override
  Future<ArtistsState> build() async {
    // TracksControllerの状態を監視
    final tracksState = await ref.watch(tracksControllerProvider.future);
    final tracks = tracksState.allTracks;

    // トラックからアーティストを生成
    final artistTracksMap = <String, Set<String>>{};
    final artistAlbumsMap = <String, Set<String>>{};

    for (final track in tracks) {
      artistTracksMap.putIfAbsent(track.artist, () => {}).add(track.id);
      artistAlbumsMap.putIfAbsent(track.artist, () => {}).add(track.album);
    }

    final allArtists = artistTracksMap.entries.map((entry) {
      return Artist(
        id: entry.key,
        name: entry.key,
        trackIds: entry.value.toList(),
        albumIds: artistAlbumsMap[entry.key]?.toList() ?? [],
      );
    }).toList();

    return ArtistsState(
      allArtists: allArtists,
      searchQuery: '',
      sortType: ArtistSortType.name,
    );
  }

  List<Artist> get filteredAndSortedArtists {
    final currentState = state.valueOrNull;
    if (currentState == null) return [];

    var artists = List<Artist>.from(currentState.allArtists);

    // フィルタリング
    if (currentState.searchQuery.isNotEmpty) {
      final lowerQuery = currentState.searchQuery.toLowerCase();
      artists = artists.where((artist) {
        return artist.name.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    // ソート
    switch (currentState.sortType) {
      case ArtistSortType.name:
        artists.sort((a, b) => a.name.compareTo(b.name));
        break;
      case ArtistSortType.albumCount:
        artists.sort((a, b) => b.albumIds.length.compareTo(a.albumIds.length));
        break;
      case ArtistSortType.trackCount:
        artists.sort((a, b) => b.trackIds.length.compareTo(a.trackIds.length));
        break;
    }

    return artists;
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

  void updateSortType(ArtistSortType type) {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(sortType: type));
    }
  }
}
