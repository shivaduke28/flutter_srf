// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Album _$AlbumFromJson(Map<String, dynamic> json) => _Album(
  id: json['id'] as String,
  name: json['name'] as String,
  path: json['path'] as String,
  srfContainerIds: (json['srfContainerIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  artist: json['artist'] as String?,
  coverImagePath: json['coverImagePath'] as String?,
  year: (json['year'] as num?)?.toInt(),
  genres: (json['genres'] as List<dynamic>?)?.map((e) => e as String).toList(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  modifiedAt: json['modifiedAt'] == null
      ? null
      : DateTime.parse(json['modifiedAt'] as String),
);

Map<String, dynamic> _$AlbumToJson(_Album instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'path': instance.path,
  'srfContainerIds': instance.srfContainerIds,
  'artist': instance.artist,
  'coverImagePath': instance.coverImagePath,
  'year': instance.year,
  'genres': instance.genres,
  'createdAt': instance.createdAt?.toIso8601String(),
  'modifiedAt': instance.modifiedAt?.toIso8601String(),
};
