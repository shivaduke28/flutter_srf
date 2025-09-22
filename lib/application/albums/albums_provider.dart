import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../tracks/track.dart';
import '../tracks/tracks_provider.dart';

part 'albums_provider.g.dart';

@riverpod
Future<List<AlbumInfo>> albumList(Ref ref) async {
  final containers = await ref.watch(tracksProvider.future);

  final albumMap = <String, List<Track>>{};

  for (final container in containers) {
    final album = container.metadata.album ?? 'Unknown Album';
    albumMap.putIfAbsent(album, () => []).add(container);
  }

  // アルバム内の曲をトラック番号でソート
  for (final tracks in albumMap.values) {
    tracks.sort((a, b) {
      final aTrack = a.metadata.trackNumber ?? 999;
      final bTrack = b.metadata.trackNumber ?? 999;
      return aTrack.compareTo(bTrack);
    });
  }

  return albumMap.entries.map((entry) {
    final albumName = entry.key;
    final tracks = entry.value;
    final firstTrack = tracks.first;

    return AlbumInfo(
      name: albumName,
      artist: firstTrack.metadata.albumArtist ?? firstTrack.metadata.artist,
      year: firstTrack.metadata.year,
      trackCount: tracks.length,
      tracks: tracks,
    );
  }).toList()..sort((a, b) => a.name.compareTo(b.name));
}

class AlbumInfo {
  final String name;
  final String artist;
  final int? year;
  final int trackCount;
  final List<Track> tracks;

  AlbumInfo({
    required this.name,
    required this.artist,
    this.year,
    required this.trackCount,
    required this.tracks,
  });
}
