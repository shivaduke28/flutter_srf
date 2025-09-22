import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'track.dart';
import 'tracks_provider.dart';
import 'track_sort_type_provider.dart';
import 'track_query_provider.dart';

part 'queried_tracks_provider.g.dart';

@riverpod
Future<List<Track>> queriedTracks(Ref ref) async {
  var tracks = await ref.watch(tracksProvider.future);
  final sortType = ref.watch(trackSortTypeNotifierProvider);
  final query = ref.watch(trackQueryNotifierProvider);

  // フィルタリング
  if (query.isNotEmpty) {
    final lowerQuery = query.toLowerCase();
    tracks = tracks.where((track) {
      return track.metadata.title.toLowerCase().contains(lowerQuery) ||
          track.metadata.artist.toLowerCase().contains(lowerQuery) ||
          (track.metadata.album?.toLowerCase() ?? '').contains(lowerQuery);
    }).toList();
  }

  // ソート
  switch (sortType) {
    case TrackSortType.title:
      tracks.sort((a, b) => a.metadata.title.compareTo(b.metadata.title));
      break;
    case TrackSortType.artist:
      tracks.sort((a, b) => a.metadata.artist.compareTo(b.metadata.artist));
      break;
    case TrackSortType.album:
      tracks.sort((a, b) => (a.metadata.album ?? '').compareTo(b.metadata.album ?? ''));
      break;
    case TrackSortType.dateAdded:
      // createdAtがnullの場合は最後にソート
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