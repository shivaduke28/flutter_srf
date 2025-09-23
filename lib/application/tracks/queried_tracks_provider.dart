import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_srf/application/tracks/track.dart';
import 'package:flutter_srf/application/tracks/track_query_controller.dart';
import 'package:flutter_srf/application/tracks/tracks_notifier.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'queried_tracks_provider.g.dart';

/// フィルタリング・ソート済みのトラックリストを提供
@riverpod
Future<List<Track>> queriedTracks(Ref ref) async {
  final queryState = ref.watch(trackQueryControllerProvider);
  final tracksState = await ref.watch(tracksControllerProvider.future);
  final tracks = tracksState.allTracks;

  // フィルタリング
  List<Track> filteredTracks;
  if (queryState.searchQuery.isNotEmpty) {
    final lowerQuery = queryState.searchQuery.toLowerCase();
    filteredTracks = tracks.where((track) {
      return track.title.toLowerCase().contains(lowerQuery) ||
          track.artist.toLowerCase().contains(lowerQuery) ||
          track.album.toLowerCase().contains(lowerQuery);
    }).toList();
  } else {
    filteredTracks = tracks.toList(); // コピーを作成してソート可能にする
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
