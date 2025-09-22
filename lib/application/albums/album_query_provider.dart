import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'album_query_provider.g.dart';

@riverpod
class AlbumQueryNotifier extends _$AlbumQueryNotifier {
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
