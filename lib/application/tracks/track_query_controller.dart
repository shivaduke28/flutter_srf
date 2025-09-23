import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_query_controller.freezed.dart';
part 'track_query_controller.g.dart';

enum TrackSortType { name, artist, album, duration }

@freezed
sealed class TrackQueryState with _$TrackQueryState {
  const factory TrackQueryState({required String searchQuery, required TrackSortType sortType}) = _TrackQueryState;
}

@riverpod
class TrackQueryController extends _$TrackQueryController {
  @override
  TrackQueryState build() {
    return const TrackQueryState(searchQuery: '', sortType: TrackSortType.name);
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
