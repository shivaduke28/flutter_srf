import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_srf/application/tracks/track.dart';
import 'package:flutter_srf/system/library/library_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_repository.g.dart';

@riverpod
TrackRepository trackRepository(Ref ref) {
  return TrackRepository(ref.watch(libraryServiceProvider));
}

class TrackRepository {
  final LibraryService _libraryService;

  TrackRepository(this._libraryService);

  Future<List<Track>> getAllTracks() async {
    final srfFiles = await _libraryService.loadSrfFiles();
    final tracks = <Track>[];

    for (final srf in srfFiles) {
      final now = DateTime.now();
      tracks.addAll(
        srf.tracks.map(
          (track) => Track(
            id: track.path.hashCode.toString(),
            title: track.title,
            artist: track.artist,
            album: track.album,
            duration: track.duration,
            filePath: track.path,
            // 実際のファイルパス
            createdAt: now,
            modifiedAt: now,
          ),
        ),
      );
    }

    return tracks;
  }
}
