import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'album.dart';
import '../tracks/tracks_notifier.dart';

part 'albums_provider.g.dart';

/// トラックリストからアルバムを生成する純粋なProvider
@riverpod
Future<List<Album>> albums(Ref ref) async {
  final tracksState = await ref.watch(tracksControllerProvider.future);
  final tracks = tracksState.allTracks;

  // トラックからアルバムを生成
  final albumMap = <String, List<String>>{};
  final albumArtistMap = <String, String>{};

  for (final track in tracks) {
    albumMap.putIfAbsent(track.album, () => []).add(track.id);
    albumArtistMap.putIfAbsent(track.album, () => track.artist);
  }

  return albumMap.entries.map((entry) {
    return Album(
      id: entry.key,
      name: entry.key,
      path: '', // Will be set properly later
      artist: albumArtistMap[entry.key],
      srfContainerIds: entry.value,
    );
  }).toList();
}
