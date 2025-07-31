import 'dart:io';
import 'package:flutter_media_metadata/flutter_media_metadata.dart';
import 'package:path/path.dart' as p;
import '../models/srf_metadata.dart';

class MetadataExtractorService {
  static Future<SrfMetadata?> extractMetadata(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return null;
      }

      final metadata = await MetadataRetriever.fromFile(file);

      return SrfMetadata(
        title: metadata.trackName ?? p.basenameWithoutExtension(filePath),
        artist: metadata.trackArtistNames?.join(', ') ?? 'Unknown Artist',
        duration: (metadata.trackDuration ?? 0) / 1000.0,
        trackNumber: metadata.trackNumber,
        artists: metadata.trackArtistNames,
        album: metadata.albumName,
        albumArtist: metadata.albumArtistName,
        year: metadata.year,
        genre: metadata.genre,
        dateAdded: DateTime.now(),
        lastModified: DateTime.now(),
      );
    } catch (e) {
      print('Error extracting metadata: $e');
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
