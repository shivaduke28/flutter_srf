import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:audio_metadata_reader/audio_metadata_reader.dart';
import 'package:path/path.dart' as p;

import '../../application/library/srf_metadata.dart';

class MetadataExtractorService {
  static Future<SrfMetadata?> extractMetadata(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return null;
      }

      final metadata = readMetadata(file, getImage: false);

      // アーティスト名を取得（複数アーティストの場合は結合）
      final artistNames = <String>[];
      if (metadata.artist != null && metadata.artist!.isNotEmpty) {
        artistNames.add(metadata.artist!);
      }

      // duration を秒単位に変換（audio_metadata_readerはミリ秒で返す）
      final durationInSeconds = metadata.duration?.inSeconds.toDouble() ?? 0;

      return SrfMetadata(
        title: metadata.title ?? p.basenameWithoutExtension(filePath),
        artist: metadata.artist ?? 'Unknown Artist',
        duration: durationInSeconds,
        trackNumber: metadata.trackNumber,
        artists: artistNames.isNotEmpty ? artistNames : null,
        album: metadata.album,
        albumArtist: null, // audio_metadata_reader doesn't provide albumArtist
        year: metadata.year?.year,
        genre: metadata.genres.isNotEmpty ? metadata.genres.join(', ') : null,
        dateAdded: DateTime.now(),
        lastModified: DateTime.now(),
      );
    } catch (e, stackTrace) {
      // デバッグビルドではログ出力
      assert(() {
        debugPrint('Error extracting metadata from $filePath: $e');
        debugPrint('Stack trace: $stackTrace');
        return true;
      }());
      // エラー時はnullを返してデフォルトメタデータを使用させる
      return null;
    }
  }

  static SrfMetadata createDefaultMetadata(String filePath) {
    return SrfMetadata(
      title: p.basenameWithoutExtension(filePath),
      artist: 'Unknown Artist',
      duration: 0,
      dateAdded: DateTime.now(),
      lastModified: DateTime.now(),
    );
  }
}
