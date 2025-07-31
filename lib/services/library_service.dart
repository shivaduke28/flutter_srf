import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/library_settings.dart';
import '../models/srf_container.dart';
import '../models/srf_metadata.dart';
import 'metadata_extractor_service.dart';

part 'library_service.g.dart';

@riverpod
class LibraryService extends _$LibraryService {
  static const String librarySettingsFile = 'library_settings.json';
  static const String metadataFileName = 'meta.json';

  @override
  Future<LibrarySettings> build() async {
    return await _loadSettings();
  }

  Future<LibrarySettings> _loadSettings() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final settingsFile = File(
        p.join(appDir.path, 'flutter_srf', librarySettingsFile),
      );

      if (await settingsFile.exists()) {
        final content = await settingsFile.readAsString();
        return LibrarySettings.fromJson(json.decode(content));
      }
    } catch (e) {
      print('Error loading settings: $e');
    }

    return LibrarySettings.defaultSettings();
  }

  Future<void> saveSettings(LibrarySettings settings) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final appPath = p.join(appDir.path, 'flutter_srf');
      final settingsFile = File(p.join(appPath, librarySettingsFile));

      await Directory(appPath).create(recursive: true);
      await settingsFile.writeAsString(json.encode(settings.toJson()));

      state = AsyncValue.data(settings);
    } catch (e) {
      print('Error saving settings: $e');
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> setLibraryPath(String path) async {
    final currentSettings = state.value;
    if (currentSettings != null) {
      final updatedSettings = currentSettings.copyWith(libraryPath: path);
      await saveSettings(updatedSettings);
    }
  }

  Future<void> addWatchedDirectory(String directory) async {
    final currentSettings = state.value;
    if (currentSettings != null) {
      final updatedDirs = [...currentSettings.watchedDirectories, directory];
      final updatedSettings = currentSettings.copyWith(
        watchedDirectories: updatedDirs,
      );
      await saveSettings(updatedSettings);
    }
  }

  Future<SrfContainer?> createSrfContainerFromFile(
    String sourceFilePath,
  ) async {
    final metadata =
        await MetadataExtractorService.extractMetadata(sourceFilePath) ??
        MetadataExtractorService.createDefaultMetadata(sourceFilePath);

    return await createSrfContainer(sourceFilePath, metadata);
  }

  Future<SrfContainer?> createSrfContainer(
    String sourceFilePath,
    SrfMetadata metadata,
  ) async {
    final settings = state.value;
    if (settings == null || settings.libraryPath.isEmpty) {
      throw Exception('Library path not set');
    }

    try {
      final sourceFile = File(sourceFilePath);
      if (!await sourceFile.exists()) {
        throw Exception('Source file does not exist');
      }

      final fileName = p.basenameWithoutExtension(sourceFilePath);
      final containerName = '$fileName.srf';
      final containerPath = p.join(settings.libraryPath, containerName);

      await Directory(containerPath).create(recursive: true);

      final destFilePath = p.join(containerPath, p.basename(sourceFilePath));
      await sourceFile.copy(destFilePath);

      final metadataFile = File(p.join(containerPath, metadataFileName));
      await metadataFile.writeAsString(json.encode(metadata.toJson()));

      final container = SrfContainer(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: containerName,
        path: containerPath,
        metadata: metadata,
        audioFiles: [p.basename(sourceFilePath)],
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      return container;
    } catch (e) {
      print('Error creating SRF container: $e');
      return null;
    }
  }

  Future<List<SrfContainer>> scanLibrary() async {
    final settings = state.value;
    if (settings == null || settings.libraryPath.isEmpty) {
      return [];
    }

    final containers = <SrfContainer>[];
    final libraryDir = Directory(settings.libraryPath);

    if (!await libraryDir.exists()) {
      return [];
    }

    await for (final entity in libraryDir.list()) {
      if (entity is Directory && entity.path.endsWith('.srf')) {
        final container = await _loadSrfContainer(entity.path);
        if (container != null) {
          containers.add(container);
        }
      }
    }

    return containers;
  }

  Future<SrfContainer?> _loadSrfContainer(String containerPath) async {
    try {
      final metadataFile = File(p.join(containerPath, metadataFileName));
      if (!await metadataFile.exists()) {
        return null;
      }

      final metadataContent = await metadataFile.readAsString();
      final metadata = SrfMetadata.fromJson(json.decode(metadataContent));

      final audioFiles = <String>[];
      final containerDir = Directory(containerPath);

      await for (final file in containerDir.list()) {
        if (file is File) {
          final ext = p.extension(file.path).toLowerCase();
          final settings = state.value;
          if (settings != null && settings.supportedExtensions.contains(ext)) {
            audioFiles.add(p.basename(file.path));
          }
        }
      }

      return SrfContainer(
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
}
