import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artist_sort_type_provider.g.dart';

enum ArtistSortType { name, trackCount, albumCount }

@riverpod
class ArtistSortTypeNotifier extends _$ArtistSortTypeNotifier {
  @override
  ArtistSortType build() {
    return ArtistSortType.name;
  }

  void setSortType(ArtistSortType type) {
    state = type;
  }
}
