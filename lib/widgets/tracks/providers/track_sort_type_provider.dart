import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_sort_type_provider.g.dart';

enum TrackSortType { title, artist, album, dateAdded }

@riverpod
class TrackSortTypeNotifier extends _$TrackSortTypeNotifier {
  @override
  TrackSortType build() {
    return TrackSortType.title;
  }

  void setSortType(TrackSortType type) {
    state = type;
  }
}
