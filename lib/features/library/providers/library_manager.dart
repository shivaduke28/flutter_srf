import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../tracks/models/track.dart';
import '../models/srf_metadata.dart';
import '../models/library_settings.dart';
import '../../../shared/utils/metadata_extractor_service.dart';

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
    print('LibraryManager: scanLibrary called (forceRefresh: $forceRefresh)');

    final libPath = await libraryPath;
    final containers = <Track>[];
    final libraryDir = Directory(libPath);

    if (!await libraryDir.exists()) {
      print('Library directory does not exist: ${libraryDir.path}');
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
    print('LibraryManager: Loaded ${containers.length} tracks');
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

      return Track(
        id: p.basename(containerPath).hashCode.toString(),
        name: p.basename(containerPath),
        path: containerPath,
        metadata: metadata,
        audioFiles: audioFiles,
        createdAt: null,
        modifiedAt: null,
      );
    } catch (e) {
      print('Error loading SRF container: $e');
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
        name: containerName,
        path: containerPath,
        metadata: metadata,
        audioFiles: [p.basename(sourceFilePath)],
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      state = [...state, newTrack];
      return newTrack;
    } catch (e) {
      print('Error creating SRF container: $e');
      return null;
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
