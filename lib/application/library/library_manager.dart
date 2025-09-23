import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../tracks/track.dart';
import 'srf_metadata.dart';
import '../../system/metadata/metadata_extractor_service.dart';

part 'library_manager.g.dart';

@Riverpod(keepAlive: true)
class LibraryManager extends _$LibraryManager {
  static const String metadataFileName = 'meta.json';

  @override
  List<Track> build() {
    // 初期化時に自動でライブラリをスキャン
    _initializeLibrary();
    return [];
  }

  Future<void> _initializeLibrary() async {
    await scanLibrary();
  }

  Future<String> get libraryPath async {
    final appSupportDir = await getApplicationSupportDirectory();
    return p.join(appSupportDir.path, 'library');
  }

  Future<void> scanLibrary({bool forceRefresh = false}) async {
    // LibraryManager: scanLibrary called

    final libPath = await libraryPath;
    final containers = <Track>[];
    final libraryDir = Directory(libPath);

    if (!await libraryDir.exists()) {
      // Library directory does not exist
      await libraryDir.create(recursive: true);
      state = [];
      return;
    }

    await for (final entity in libraryDir.list()) {
      if (entity is Directory && entity.path.endsWith('.srf')) {
        final container = await _loadTrack(entity.path);
        if (container != null) {
          containers.add(container);
        }
      }
    }

    state = containers;
    // Loaded tracks
  }

  Future<Track?> _loadTrack(String containerPath) async {
    try {
      final metadataFile = File(p.join(containerPath, metadataFileName));
      if (!await metadataFile.exists()) {
        return null;
      }

      final metadataContent = await metadataFile.readAsString();
      final metadata = SrfMetadata.fromJson(json.decode(metadataContent));

      final audioFiles = <String>[];
      final containerDir = Directory(containerPath);
      final supportedExtensions = ['.mp3', '.m4a', '.wav', '.flac'];

      await for (final file in containerDir.list()) {
        if (file is File) {
          final ext = p.extension(file.path).toLowerCase();
          if (supportedExtensions.contains(ext)) {
            audioFiles.add(p.basename(file.path));
          }
        }
      }

      // TODO: Convert to new Track model format
      // For now, return the first audio file as a simplified Track
      if (audioFiles.isNotEmpty) {
        return Track(
          id: p.basename(containerPath).hashCode.toString(),
          title: metadata.title,
          artist: metadata.artist,
          album: metadata.album ?? 'Unknown Album',
          duration: metadata.duration,
          filePath: audioFiles.first,
          createdAt: null,
          modifiedAt: null,
        );
      }
      return null;
    } catch (e, stackTrace) {
      // デバッグビルドではログ出力
      assert(() {
        debugPrint('Error loading SRF container from $containerPath: $e');
        debugPrint('Stack trace: $stackTrace');
        return true;
      }());
      return null;
    }
  }

  Future<Track?> createTrackFromFile(String sourceFilePath) async {
    final metadata =
        await MetadataExtractorService.extractMetadata(sourceFilePath) ??
        MetadataExtractorService.createDefaultMetadata(sourceFilePath);

    return await createTrack(sourceFilePath, metadata);
  }

  Future<Track?> createTrack(
    String sourceFilePath,
    SrfMetadata metadata,
  ) async {
    try {
      final sourceFile = File(sourceFilePath);
      if (!await sourceFile.exists()) {
        throw Exception('Source file does not exist');
      }

      final libPath = await libraryPath;
      final fileName = p.basenameWithoutExtension(sourceFilePath);
      final containerName = '$fileName.srf';
      final containerPath = p.join(libPath, containerName);

      await Directory(containerPath).create(recursive: true);

      final destFilePath = p.join(containerPath, p.basename(sourceFilePath));
      await sourceFile.copy(destFilePath);

      final metadataFile = File(p.join(containerPath, metadataFileName));
      await metadataFile.writeAsString(json.encode(metadata.toJson()));

      // 新しいトラックを作成して状態を更新
      final newTrack = Track(
        id: containerName.hashCode.toString(),
        title: metadata.title,
        artist: metadata.artist,
        album: metadata.album ?? 'Unknown Album',
        duration: metadata.duration,
        filePath: destFilePath,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      state = [...state, newTrack];
      return newTrack;
    } catch (e, stackTrace) {
      // デバッグビルドではログ出力
      assert(() {
        debugPrint('Error creating SRF container: $e');
        debugPrint('Stack trace: $stackTrace');
        return true;
      }());
      rethrow; // エラーを再スロー
    }
  }

  void updateTrack(String id, Track updatedTrack) {
    state = [
      for (final track in state)
        if (track.id == id) updatedTrack else track,
    ];
  }

  void removeTrack(String id) {
    state = state.where((track) => track.id != id).toList();
  }

  Track? getTrack(String id) {
    try {
      return state.firstWhere((track) => track.id == id);
    } catch (_) {
      return null;
    }
  }
}
