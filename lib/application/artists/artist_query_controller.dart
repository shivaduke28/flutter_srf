import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artist_query_controller.freezed.dart';
part 'artist_query_controller.g.dart';

enum ArtistSortType { name, albumCount, trackCount }

@freezed
sealed class ArtistQueryState with _$ArtistQueryState {
  const factory ArtistQueryState({
    required String searchQuery,
    required ArtistSortType sortType,
  }) = _ArtistQueryState;
}

@riverpod
class ArtistQueryController extends _$ArtistQueryController {
  @override
  ArtistQueryState build() {
    return const ArtistQueryState(
      searchQuery: '',
      sortType: ArtistSortType.name,
    );
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void clearSearchQuery() {
    state = state.copyWith(searchQuery: '');
  }

  void updateSortType(ArtistSortType type) {
    state = state.copyWith(sortType: type);
  }
}
