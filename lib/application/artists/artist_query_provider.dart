import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'artist_query_provider.g.dart';

@riverpod
class ArtistQueryNotifier extends _$ArtistQueryNotifier {
  @override
  String build() {
    return '';
  }

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }
}
