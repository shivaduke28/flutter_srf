import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/track.dart';
import '../../library/providers/library_manager.dart';

part 'tracks_controller.freezed.dart';
part 'tracks_controller.g.dart';

enum TrackSortType { title, artist, album, dateAdded }

@freezed
sealed class TracksState with _$TracksState {
  const factory TracksState({
    required List<Track> allTracks,
    required String searchQuery,
    required TrackSortType sortType,
  }) = _TracksState;
}

@riverpod
class TracksController extends _$TracksController {
  @override
  TracksState build() {
    final allTracks = ref.watch(libraryManagerProvider);
    return TracksState(
      allTracks: allTracks,
      searchQuery: '',
      sortType: TrackSortType.title,
    );
  }

  List<Track> get filteredAndSortedTracks {
    var tracks = List<Track>.from(state.allTracks);

    // フィルタリング
    if (state.searchQuery.isNotEmpty) {
      final lowerQuery = state.searchQuery.toLowerCase();
      tracks = tracks.where((track) {
        return track.metadata.title.toLowerCase().contains(lowerQuery) ||
            track.metadata.artist.toLowerCase().contains(lowerQuery) ||
            (track.metadata.album?.toLowerCase() ?? '').contains(lowerQuery);
      }).toList();
    }

    // ソート
    switch (state.sortType) {
      case TrackSortType.title:
        tracks.sort((a, b) => a.metadata.title.compareTo(b.metadata.title));
        break;
      case TrackSortType.artist:
        tracks.sort((a, b) => a.metadata.artist.compareTo(b.metadata.artist));
        break;
      case TrackSortType.album:
        tracks.sort(
          (a, b) => (a.metadata.album ?? '').compareTo(b.metadata.album ?? ''),
        );
        break;
      case TrackSortType.dateAdded:
        tracks.sort((a, b) {
          if (a.createdAt == null && b.createdAt == null) return 0;
          if (a.createdAt == null) return 1;
          if (b.createdAt == null) return -1;
          return b.createdAt!.compareTo(a.createdAt!);
        });
        break;
    }

    return tracks;
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void clearSearchQuery() {
    state = state.copyWith(searchQuery: '');
  }

  void updateSortType(TrackSortType type) {
    state = state.copyWith(sortType: type);
  }
}
