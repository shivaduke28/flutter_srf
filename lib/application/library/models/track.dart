import 'package:freezed_annotation/freezed_annotation.dart';
import 'srf_metadata.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
sealed class Track with _$Track {
  const factory Track({
    required String id,
    required String name,
    required String path,
    required SrfMetadata metadata,
    required List<String> audioFiles,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) = _Track;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}
