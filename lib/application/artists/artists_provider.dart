import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'artist.dart';
import '../tracks/tracks_notifier.dart';

part 'artists_provider.g.dart';

/// トラックリストからアーティストを生成する純粋なProvider
@riverpod
Future<List<Artist>> artists(Ref ref) async {
  final tracksState = await ref.watch(tracksControllerProvider.future);
  final tracks = tracksState.allTracks;

  // トラックからアーティストを生成
  final artistTracksMap = <String, Set<String>>{};
  final artistAlbumsMap = <String, Set<String>>{};

  for (final track in tracks) {
    artistTracksMap.putIfAbsent(track.artist, () => {}).add(track.id);
    artistAlbumsMap.putIfAbsent(track.artist, () => {}).add(track.album);
  }

  return artistTracksMap.entries.map((entry) {
    return Artist(
      id: entry.key,
      name: entry.key,
      trackIds: entry.value.toList(),
      albumIds: artistAlbumsMap[entry.key]?.toList() ?? [],
    );
  }).toList();
}
