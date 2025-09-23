import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'track.dart';
import '../../system/library/library_service.dart';

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
      tracks.addAll(
        srf.tracks.map(
          (track) => Track(
            id: '${srf.path}#${track.path}',
            title: track.title,
            artist: track.artist,
            album: track.album,
            duration: track.duration,
            filePath: '${srf.path}#${track.path}',
          ),
        ),
      );
    }

    return tracks;
  }

  Future<void> scanLibrary() async {
    await _libraryService.scanLibrary();
  }

  Future<void> importTracks(String sourcePath) async {
    await _libraryService.importTracks(sourcePath);
  }
}
