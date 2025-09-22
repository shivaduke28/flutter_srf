import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_query_provider.g.dart';

@riverpod
class TrackQueryNotifier extends _$TrackQueryNotifier {
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
