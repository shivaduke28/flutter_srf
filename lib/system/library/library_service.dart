import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_srf/errors/exceptions.dart';
import 'package:flutter_srf/system/library/srf_file.dart';
import 'package:flutter_srf/system/library/srf_track.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'library_service.g.dart';

@Riverpod(keepAlive: true)
LibraryService libraryService(Ref ref) {
  return LibraryService();
}

class LibraryService {
  Future<String> get libraryPath async {
    try {
      final appSupport = await getApplicationSupportDirectory();
      final libraryDir = Directory(path.join(appSupport.path, 'library'));

      if (!await libraryDir.exists()) {
        await libraryDir.create(recursive: true);
      }

      return libraryDir.path;
    } on FileSystemException catch (e, stack) {
      throw LibraryAccessException(message: 'ライブラリディレクトリの作成に失敗しました', originalError: e, stackTrace: stack);
    } catch (e, stack) {
      throw LibraryAccessException(message: 'ライブラリパスの取得に失敗しました', originalError: e, stackTrace: stack);
    }
  }

  Future<List<SrfFile>> loadSrfFiles() async {
    try {
      final libPath = await libraryPath;
      final dir = Directory(libPath);

      if (!await dir.exists()) {
        return [];
      }

      final srfFiles = <SrfFile>[];
      final entities = await dir.list().toList();

      for (final entity in entities) {
        if (entity is Directory && entity.path.endsWith('.srf')) {
          try {
            final tracks = await _loadTracksFromContainer(entity);
            final containerName = path.basename(entity.path);
            srfFiles.add(SrfFile(path: entity.path, name: containerName, tracks: tracks));
          } catch (e) {
            // 単一のコンテナの読み込みエラーはスキップして続行
            debugPrint('コンテナの読み込みに失敗: ${entity.path}: $e');
            continue;
          }
        }
      }

      return srfFiles;
    } on LibraryAccessException {
      rethrow;
    } on FileSystemException catch (e, stack) {
      throw LibraryAccessException(message: 'ライブラリファイルの読み込みに失敗しました', originalError: e, stackTrace: stack);
    } catch (e, stack) {
      throw LibraryAccessException(message: '予期しないエラーが発生しました', originalError: e, stackTrace: stack);
    }
  }

  Future<List<SrfTrack>> _loadTracksFromContainer(Directory containerDir) async {
    final tracks = <SrfTrack>[];

    // メタデータファイルを読む
    final metadataFile = File(path.join(containerDir.path, 'meta.json'));
    Map<String, dynamic>? metadata;

    if (await metadataFile.exists()) {
      try {
        final content = await metadataFile.readAsString();
        metadata = json.decode(content) as Map<String, dynamic>?;
      } on FormatException catch (e) {
        // JSONパースエラーはログ出力して続行
        debugPrint('メタデータのJSONパースエラー: $e');
      } catch (e) {
        // その他のメタデータ読み込みエラーもログ出力して続行
        debugPrint('メタデータ読み込みエラー: $e');
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
              title: metadata?['title'] as String? ?? path.basenameWithoutExtension(entity.path),
              artist: metadata?['artist'] as String? ?? 'Unknown Artist',
              album: metadata?['album'] as String? ?? 'Unknown Album',
              duration: (metadata?['duration'] as num? ?? 0.0).toDouble(),
            ),
          );
        }
      }
    }

    return tracks;
  }
}
