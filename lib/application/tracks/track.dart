import 'package:freezed_annotation/freezed_annotation.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
sealed class Track with _$Track {
  const factory Track({
    required String id,
    required String title,
    required String artist,
    required String album,
    required double duration,
    required String filePath,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) = _Track;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}
