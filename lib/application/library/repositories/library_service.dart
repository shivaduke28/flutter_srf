import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/library_settings.dart';
import '../models/track.dart';
import '../models/srf_metadata.dart';
import '../../../system/metadata/metadata_extractor_service.dart';

part 'library_service.g.dart';

@Riverpod(keepAlive: true)
class LibraryService extends _$LibraryService {
  static const String metadataFileName = 'meta.json';

  // キャッシュ管理
  List<Track>? _cachedContainers;

  @override
  Future<LibrarySettings> build() async {
    return await _loadSettings();
  }

  Future<LibrarySettings> _loadSettings() async {
    // 常にアプリケーションサポートディレクトリを使用
    final appSupportDir = await getApplicationSupportDirectory();
    final libraryPath = p.join(appSupportDir.path, 'library');

    return LibrarySettings.defaultSettings().copyWith(libraryPath: libraryPath);
  }

  Future<void> saveSettings(LibrarySettings settings) async {
    // 現在は設定の保存は行わない
    state = AsyncValue.data(settings);
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
    var settings = state.value;
    if (settings == null) {
      throw Exception('Settings not loaded');
    }

    // ライブラリパスが空の場合、デフォルトパスを設定して保存
    if (settings.libraryPath.isEmpty) {
      final appSupportDir = await getApplicationSupportDirectory();
      final defaultLibraryPath = p.join(appSupportDir.path, 'library');
      settings = settings.copyWith(libraryPath: defaultLibraryPath);
      await saveSettings(settings);
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
    } catch (e) {
      print('Error creating SRF container: $e');
      return null;
    }

    // returnステートメントがなかったので追加
    return null;
  }

  Future<List<Track>> scanLibrary({bool forceRefresh = false}) async {
    // キャッシュがあり、強制リフレッシュでない場合はキャッシュを返す
    if (!forceRefresh && _cachedContainers != null) {
      print('Returning cached containers');
      return _cachedContainers!;
    }

    print('scanLibrary called (forceRefresh: $forceRefresh)');
    final settings = state.value;
    if (settings == null || settings.libraryPath.isEmpty) {
      print('Library path is not set: settings=$settings');
      return [];
    }
    print('Scanning library at: ${settings.libraryPath}');

    final containers = <Track>[];
    final libraryDir = Directory(settings.libraryPath);

    if (!await libraryDir.exists()) {
      print('Library directory does not exist: ${libraryDir.path}');
      return [];
    }

    await for (final entity in libraryDir.list()) {
      if (entity is Directory && entity.path.endsWith('.srf')) {
        final container = await _loadTrack(entity.path);
        if (container != null) {
          containers.add(container);
        }
      }
    }

    // キャッシュを更新
    _cachedContainers = containers;

    return containers;
  }

  // キャッシュをクリアする
  void clearCache() {
    _cachedContainers = null;
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

      await for (final file in containerDir.list()) {
        if (file is File) {
          final ext = p.extension(file.path).toLowerCase();
          final settings = state.value;
          if (settings != null && settings.supportedExtensions.contains(ext)) {
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
}
