import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'track.dart';
import 'tracks_notifier.dart';
import 'track_query_controller.dart';

part 'queried_tracks_provider.g.dart';

/// フィルタリング・ソート済みのトラックリストを提供
@riverpod
Future<List<Track>> queriedTracks(Ref ref) async {
  final queryState = ref.watch(trackQueryControllerProvider);
  final tracksState = await ref.watch(tracksControllerProvider.future);
  final tracks = tracksState.allTracks;

  // フィルタリング
  var filteredTracks = tracks;
  if (queryState.searchQuery.isNotEmpty) {
    final lowerQuery = queryState.searchQuery.toLowerCase();
    filteredTracks = tracks.where((track) {
      return track.title.toLowerCase().contains(lowerQuery) ||
          track.artist.toLowerCase().contains(lowerQuery) ||
          track.album.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  // ソート
  switch (queryState.sortType) {
    case TrackSortType.name:
      filteredTracks.sort((a, b) => a.title.compareTo(b.title));
      break;
    case TrackSortType.artist:
      filteredTracks.sort((a, b) => a.artist.compareTo(b.artist));
      break;
    case TrackSortType.album:
      filteredTracks.sort((a, b) => a.album.compareTo(b.album));
      break;
    case TrackSortType.duration:
      filteredTracks.sort((a, b) => b.duration.compareTo(a.duration));
      break;
  }

  return filteredTracks;
}
