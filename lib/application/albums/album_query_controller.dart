import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'album_query_controller.freezed.dart';
part 'album_query_controller.g.dart';

enum AlbumSortType { name, artist, trackCount }

@freezed
sealed class AlbumQueryState with _$AlbumQueryState {
  const factory AlbumQueryState({
    required String searchQuery,
    required AlbumSortType sortType,
  }) = _AlbumQueryState;
}

@riverpod
class AlbumQueryController extends _$AlbumQueryController {
  @override
  AlbumQueryState build() {
    return const AlbumQueryState(searchQuery: '', sortType: AlbumSortType.name);
  }

  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void clearSearchQuery() {
    state = state.copyWith(searchQuery: '');
  }

  void updateSortType(AlbumSortType type) {
    state = state.copyWith(sortType: type);
  }
}
