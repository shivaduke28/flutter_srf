import 'package:freezed_annotation/freezed_annotation.dart';

part 'artist.freezed.dart';
part 'artist.g.dart';

@freezed
sealed class Artist with _$Artist {
  const factory Artist({
    required String id,
    required String name,
    required List<String> albumIds,
    required List<String> trackIds,
  }) = _Artist;

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);
}
