import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'srf_file.dart';
import 'srf_track.dart';

part 'library_service.g.dart';

@Riverpod(keepAlive: true)
LibraryService libraryService(Ref ref) {
  return LibraryService();
}

class LibraryService {
  static const String _appName = 'flutter_srf';
  static const String _librarySubdir = 'library';

  Future<String> get libraryPath async {
    final appSupport = await getApplicationSupportDirectory();
    final libraryDir = Directory(
      path.join(appSupport.path, _appName, _librarySubdir),
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
      if (entity is File && entity.path.endsWith('.srf')) {
        final containerName = path.basenameWithoutExtension(entity.path);
        final containerDir = Directory(path.join(libPath, containerName));

        if (await containerDir.exists()) {
          final tracks = await _loadTracksFromContainer(containerDir);
          srfFiles.add(
            SrfFile(path: entity.path, name: containerName, tracks: tracks),
          );
        }
      }
    }

    return srfFiles;
  }

  Future<List<SrfTrack>> _loadTracksFromContainer(
    Directory containerDir,
  ) async {
    final tracks = <SrfTrack>[];
    final entities = await containerDir.list().toList();

    for (final entity in entities) {
      if (entity is File && entity.path.endsWith('.mp3')) {
        final metadata = await _extractMetadata(entity);
        tracks.add(
          SrfTrack(
            path: entity.path,
            title:
                metadata['title'] ?? path.basenameWithoutExtension(entity.path),
            artist: metadata['artist'] ?? 'Unknown Artist',
            album: metadata['album'] ?? 'Unknown Album',
            duration: metadata['duration'] ?? 0.0,
          ),
        );
      }
    }

    return tracks;
  }

  Future<Map<String, dynamic>> _extractMetadata(File file) async {
    try {
      final metadata = readMetadata(file, getImage: false);
      return {
        'title': metadata.title ?? path.basenameWithoutExtension(file.path),
        'artist': metadata.artist ?? 'Unknown Artist',
        'album': metadata.album ?? 'Unknown Album',
        'duration': metadata.duration?.inMilliseconds != null
            ? metadata.duration!.inMilliseconds / 1000.0
            : 0.0,
      };
    } catch (e) {
      // TODO: Use proper logging framework
      // print('Failed to extract metadata from ${file.path}: $e');
      return {
        'title': path.basenameWithoutExtension(file.path),
        'artist': 'Unknown Artist',
        'album': 'Unknown Album',
        'duration': 0.0,
      };
    }
  }

  Future<void> scanLibrary() async {
    // Force reload of library
    await loadSrfFiles();
  }

  Future<void> importTracks(String sourcePath) async {
    final sourceDir = Directory(sourcePath);
    if (!await sourceDir.exists()) {
      throw Exception('Source directory does not exist');
    }

    final libPath = await libraryPath;
    final containerName = 'imported_${DateTime.now().millisecondsSinceEpoch}';
    final containerDir = Directory(path.join(libPath, containerName));
    await containerDir.create(recursive: true);

    // Create SRF marker file
    final srfFile = File(path.join(libPath, '$containerName.srf'));
    await srfFile.writeAsString('SRF Container');

    // Copy MP3 files
    final entities = await sourceDir.list(recursive: true).toList();
    var trackIndex = 0;

    for (final entity in entities) {
      if (entity is File && entity.path.endsWith('.mp3')) {
        trackIndex++;
        final destPath = path.join(containerDir.path, 'track_$trackIndex.mp3');
        await entity.copy(destPath);
      }
    }
  }
}
