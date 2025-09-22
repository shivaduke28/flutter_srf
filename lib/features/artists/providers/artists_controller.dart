import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'artists_provider.dart';

part 'artists_controller.freezed.dart';
part 'artists_controller.g.dart';

enum ArtistSortType { name, trackCount, albumCount }

@freezed
sealed class ArtistsState with _$ArtistsState {
  const factory ArtistsState({
    required List<ArtistInfo> allArtists,
    required String searchQuery,
    required ArtistSortType sortType,
  }) = _ArtistsState;
}

@riverpod
class ArtistsController extends _$ArtistsController {
  @override
  Future<ArtistsState> build() async {
    final allArtists = await ref.watch(artistsListProvider.future);
    return ArtistsState(
      allArtists: allArtists,
      searchQuery: '',
      sortType: ArtistSortType.name,
    );
  }

  List<ArtistInfo> get filteredAndSortedArtists {
    final currentState = state.valueOrNull;
    if (currentState == null) return [];

    var artists = List<ArtistInfo>.from(currentState.allArtists);

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
      case ArtistSortType.trackCount:
        artists.sort((a, b) => b.trackCount.compareTo(a.trackCount));
        break;
      case ArtistSortType.albumCount:
        artists.sort((a, b) => b.albumCount.compareTo(a.albumCount));
        break;
    }

    return artists;
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

  void updateSortType(ArtistSortType type) {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncValue.data(currentState.copyWith(sortType: type));
    }
  }
}
