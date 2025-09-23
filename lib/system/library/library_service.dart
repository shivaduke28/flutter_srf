import 'dart:io';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'srf_file.dart';
import 'srf_track.dart';

part 'library_service.g.dart';

@Riverpod(keepAlive: true)
LibraryService libraryService(Ref ref) {
  return LibraryService();
}

class LibraryService {
  Future<String> get libraryPath async {
    final appSupport = await getApplicationSupportDirectory();
    final libraryDir = Directory(
      path.join(appSupport.path, 'library'),
    );

    if (!await libraryDir.exists()) {
      await libraryDir.create(recursive: true);
    }

    return libraryDir.path;
  }

  Future<List<SrfFile>> loadSrfFiles() async {
    final libPath = await libraryPath;
    final dir = Directory(libPath);

    if (!await dir.exists()) {
      return [];
    }

    final srfFiles = <SrfFile>[];
    final entities = await dir.list().toList();

    for (final entity in entities) {
      if (entity is Directory && entity.path.endsWith('.srf')) {
        final tracks = await _loadTracksFromContainer(entity);
        final containerName = path.basename(entity.path);
        srfFiles.add(
          SrfFile(path: entity.path, name: containerName, tracks: tracks),
        );
      }
    }

    return srfFiles;
  }

  Future<List<SrfTrack>> _loadTracksFromContainer(
    Directory containerDir,
  ) async {
    final tracks = <SrfTrack>[];

    // メタデータファイルを読む
    final metadataFile = File(path.join(containerDir.path, 'meta.json'));
    Map<String, dynamic>? metadata;

    if (await metadataFile.exists()) {
      try {
        final content = await metadataFile.readAsString();
        metadata = json.decode(content);
      } catch (_) {
        // メタデータ読み込みエラーは無視
      }
    }

    // オーディオファイルを探す
    final entities = await containerDir.list().toList();
    for (final entity in entities) {
      if (entity is File) {
        final ext = path.extension(entity.path).toLowerCase();
        if (['.mp3', '.m4a', '.wav', '.flac'].contains(ext)) {
          tracks.add(
            SrfTrack(
              path: entity.path,
              title: metadata?['title'] ?? path.basenameWithoutExtension(entity.path),
              artist: metadata?['artist'] ?? 'Unknown Artist',
              album: metadata?['album'] ?? 'Unknown Album',
              duration: (metadata?['duration'] ?? 0.0).toDouble(),
            ),
          );
        }
      }
    }

    return tracks;
  }

}
