import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/track.dart';
import '../repositories/library_service.dart';

part 'import_service.g.dart';

@riverpod
class ImportService extends _$ImportService {
  @override
  ImportProgress build() {
    return const ImportProgress(
      totalFiles: 0,
      processedFiles: 0,
      currentFile: '',
      isImporting: false,
    );
  }

  Future<List<Track>> importDirectory(String directoryPath) async {
    final libraryService = ref.read(libraryServiceProvider.notifier);
    final settings = await ref.read(libraryServiceProvider.future);

    if (settings.libraryPath.isEmpty) {
      throw Exception('Library path not set');
    }

    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      throw Exception('Directory does not exist');
    }

    final audioFiles = <File>[];
    await for (final entity in directory.list(recursive: true)) {
      if (entity is File) {
        final ext = p.extension(entity.path).toLowerCase();
        if (settings.supportedExtensions.contains(ext)) {
          audioFiles.add(entity);
        }
      }
    }

    state = ImportProgress(
      totalFiles: audioFiles.length,
      processedFiles: 0,
      currentFile: '',
      isImporting: true,
    );

    final containers = <Track>[];
    for (var i = 0; i < audioFiles.length; i++) {
      final file = audioFiles[i];

      state = state.copyWith(
        processedFiles: i,
        currentFile: p.basename(file.path),
      );

      try {
        final container = await libraryService.createTrackFromFile(file.path);
        if (container != null) {
          containers.add(container);
        }
      } catch (e) {
        print('Error importing file ${file.path}: $e');
      }
    }

    state = state.copyWith(
      processedFiles: audioFiles.length,
      isImporting: false,
    );

    return containers;
  }

  void cancelImport() {
    state = state.copyWith(isImporting: false);
  }
}

class ImportProgress {
  final int totalFiles;
  final int processedFiles;
  final String currentFile;
  final bool isImporting;

  const ImportProgress({
    required this.totalFiles,
    required this.processedFiles,
    required this.currentFile,
    required this.isImporting,
  });

  ImportProgress copyWith({
    int? totalFiles,
    int? processedFiles,
    String? currentFile,
    bool? isImporting,
  }) {
    return ImportProgress(
      totalFiles: totalFiles ?? this.totalFiles,
      processedFiles: processedFiles ?? this.processedFiles,
      currentFile: currentFile ?? this.currentFile,
      isImporting: isImporting ?? this.isImporting,
    );
  }

  double get progress {
    if (totalFiles == 0) return 0;
    return processedFiles / totalFiles;
  }
}
