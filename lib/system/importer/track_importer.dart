import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'metadata_extractor_service.dart';

part 'track_importer.g.dart';

@riverpod
TrackImporter trackImporter(Ref ref) {
  return TrackImporter();
}

sealed class ImportEvent {
  const ImportEvent();
}

class ImportStarted extends ImportEvent {
  final int totalFiles;

  const ImportStarted({required this.totalFiles});
}

class ImportProgress extends ImportEvent {
  final int processedFiles;
  final String currentFile;

  const ImportProgress({
    required this.processedFiles,
    required this.currentFile,
  });
}

class ImportCompleted extends ImportEvent {
  final List<String> importedContainerPaths;

  const ImportCompleted({required this.importedContainerPaths});
}

class ImportError extends ImportEvent {
  final String filePath;
  final String error;

  const ImportError({required this.filePath, required this.error});
}

class TrackImporter {
  static const String metadataFileName = 'meta.json';

  Future<List<String>> importDirectory(
    String directoryPath,
    String libraryPath,
    void Function(ImportEvent)? onProgress,
  ) async {
    final supportedExtensions = ['.mp3', '.m4a', '.wav', '.flac'];

    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      throw Exception('Directory does not exist');
    }

    // スキャンして対象ファイルを収集
    final audioFiles = <File>[];
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) {
        final ext = p.extension(entity.path).toLowerCase();
        if (supportedExtensions.contains(ext)) {
          audioFiles.add(entity);
        }
      }
    }

    onProgress?.call(ImportStarted(totalFiles: audioFiles.length));

    final importedContainerPaths = <String>[];

    for (var i = 0; i < audioFiles.length; i++) {
      final file = audioFiles[i];

      onProgress?.call(
        ImportProgress(processedFiles: i, currentFile: p.basename(file.path)),
      );

      try {
        final containerPath = await _importSingleFile(file.path, libraryPath);
        if (containerPath != null) {
          importedContainerPaths.add(containerPath);
        }
      } catch (e) {
        onProgress?.call(ImportError(filePath: file.path, error: e.toString()));

        // デバッグビルドではログ出力
        assert(() {
          debugPrint('Error importing file ${file.path}: $e');
          return true;
        }());
      }
    }

    onProgress?.call(
      ImportCompleted(importedContainerPaths: importedContainerPaths),
    );

    return importedContainerPaths;
  }

  Future<String?> _importSingleFile(
    String sourceFilePath,
    String libraryPath,
  ) async {
    final sourceFile = File(sourceFilePath);
    if (!await sourceFile.exists()) {
      return null;
    }

    // メタデータを抽出
    final metadata =
        await MetadataExtractorService.extractMetadata(sourceFilePath) ??
        MetadataExtractorService.createDefaultMetadata(sourceFilePath);

    // SRFコンテナを作成
    final fileName = p.basenameWithoutExtension(sourceFilePath);
    final containerName =
        '${fileName}_${DateTime.now().millisecondsSinceEpoch}.srf';
    final containerPath = p.join(libraryPath, containerName);

    await Directory(containerPath).create(recursive: true);

    // オーディオファイルをコピー
    final destFilePath = p.join(containerPath, p.basename(sourceFilePath));
    await sourceFile.copy(destFilePath);

    // メタデータファイルを作成
    final metadataFile = File(p.join(containerPath, metadataFileName));
    await metadataFile.writeAsString(json.encode(metadata.toJson()));

    return containerPath;
  }
}
