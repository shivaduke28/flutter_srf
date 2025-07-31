import 'package:freezed_annotation/freezed_annotation.dart';

part 'album.freezed.dart';
part 'album.g.dart';

@freezed
sealed class Album with _$Album {
  const factory Album({
    required String id,
    required String name,
    required String path,
    String? artist,
    String? coverImagePath,
    int? year,
    List<String>? genres,
    required List<String> srfContainerIds,
    DateTime? createdAt,
    DateTime? modifiedAt,
  }) = _Album;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
}
