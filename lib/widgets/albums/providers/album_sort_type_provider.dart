import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'album_sort_type_provider.g.dart';

enum AlbumSortType { name, artist, year, trackCount }

@riverpod
class AlbumSortTypeNotifier extends _$AlbumSortTypeNotifier {
  @override
  AlbumSortType build() {
    return AlbumSortType.name;
  }

  void setSortType(AlbumSortType type) {
    state = type;
  }
}
