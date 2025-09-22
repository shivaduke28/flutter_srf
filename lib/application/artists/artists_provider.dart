import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../tracks/track.dart';
import '../tracks/tracks_provider.dart';

part 'artists_provider.g.dart';

@riverpod
Future<Map<String, List<Track>>> artists(Ref ref) async {
  final containers = await ref.watch(tracksProvider.future);

  final artistMap = <String, List<Track>>{};

  for (final container in containers) {
    // アーティスト名を取得（複数アーティストの場合は個別に処理）
    final artists = container.metadata.artists ?? [container.metadata.artist];

    for (final artist in artists) {
      artistMap.putIfAbsent(artist, () => []).add(container);
    }
  }

  // 各アーティストの曲をアルバム、トラック番号順にソート
  for (final tracks in artistMap.values) {
    tracks.sort((a, b) {
      // まずアルバムでソート
      final albumCompare = (a.metadata.album ?? '').compareTo(
        b.metadata.album ?? '',
      );
      if (albumCompare != 0) return albumCompare;

      // 同じアルバムならトラック番号でソート
      final aTrack = a.metadata.trackNumber ?? 999;
      final bTrack = b.metadata.trackNumber ?? 999;
      return aTrack.compareTo(bTrack);
    });
  }

  return artistMap;
}

@riverpod
Future<List<ArtistInfo>> artistsList(Ref ref) async {
  final artistMap = await ref.watch(artistsProvider.future);

  return artistMap.entries.map((entry) {
    final artistName = entry.key;
    final tracks = entry.value;

    // アルバム数を計算
    final albums = tracks
        .map((track) => track.metadata.album ?? 'Unknown Album')
        .toSet()
        .length;

    return ArtistInfo(
      name: artistName,
      albumCount: albums,
      trackCount: tracks.length,
      tracks: tracks,
    );
  }).toList()..sort((a, b) => a.name.compareTo(b.name));
}

class ArtistInfo {
  final String name;
  final int albumCount;
  final int trackCount;
  final List<Track> tracks;

  ArtistInfo({
    required this.name,
    required this.albumCount,
    required this.trackCount,
    required this.tracks,
  });
}
