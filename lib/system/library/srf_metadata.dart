import 'package:freezed_annotation/freezed_annotation.dart';

part 'srf_metadata.freezed.dart';
part 'srf_metadata.g.dart';

@freezed
sealed class SrfMetadata with _$SrfMetadata {
  const factory SrfMetadata({
    required String title,
    required String artist,
    required double duration,
    int? trackNumber,
    List<String>? artists,
    String? album,
    String? albumArtist,
    int? year,
    String? genre,
    String? comment,
    DateTime? dateAdded,
    DateTime? lastModified,
  }) = _SrfMetadata;

  factory SrfMetadata.fromJson(Map<String, dynamic> json) => _$SrfMetadataFromJson(json);
}
